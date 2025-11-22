import os
import sys
import json
import time
import requests
from pathlib import Path

def parse_srt(srt_file):
    """Parse SRT file and extract text segments with timestamps"""
    with open(srt_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    segments = []
    blocks = content.strip().split('\n\n')
    
    for block in blocks:
        lines = block.split('\n')
        if len(lines) >= 3:
            # index = lines[0]
            timestamp = lines[1]
            text = ' '.join(lines[2:])
            
            # Parse timestamp to get duration
            times = timestamp.split(' --> ')
            start = times[0]
            end = times[1]
            
            segments.append({
                'text': text,
                'start': start,
                'end': end
            })
    
    return segments

def generate_elevenlabs_tts(text, api_key, voice_id, output_file, retries=2):
    """Generate TTS using ElevenLabs API"""
    url = f"https://api.elevenlabs.io/v1/text-to-speech/{voice_id}"
    
    headers = {
        "Accept": "audio/mpeg",
        "Content-Type": "application/json",
        "xi-api-key": api_key
    }
    
    data = {
        "text": text,
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {
            "stability": 0.5,
            "similarity_boost": 0.75
        }
    }
    
    for attempt in range(retries + 1):
        try:
            print(f"Generating audio for: {text[:50]}...")
            response = requests.post(url, json=data, headers=headers, timeout=30)
            
            if response.status_code == 200:
                with open(output_file, 'wb') as f:
                    f.write(response.content)
                print(f"✓ Audio saved to {output_file}")
                return True
            else:
                print(f"✗ ElevenLabs API error: {response.status_code} - {response.text}")
                if attempt < retries:
                    time.sleep(0.5 * (attempt + 1))
        except Exception as e:
            print(f"✗ Request failed: {e}")
            if attempt < retries:
                time.sleep(0.5 * (attempt + 1))
    
    return False

def generate_gtts_fallback(text, output_file):
    """Fallback to gTTS if ElevenLabs fails"""
    try:
        from gtts import gTTS
        print(f"Using gTTS fallback for: {text[:50]}...")
        tts = gTTS(text=text, lang='en')
        tts.save(output_file)
        print(f"✓ Audio saved to {output_file}")
        return True
    except Exception as e:
        print(f"✗ gTTS failed: {e}")
        return False

def combine_audio_segments(segment_files, output_file):
    """Combine multiple audio files into one"""
    try:
        from pydub import AudioSegment
        combined = AudioSegment.empty()
        
        for file in segment_files:
            if os.path.exists(file):
                audio = AudioSegment.from_mp3(file)
                combined += audio
                # Add small pause between segments
                combined += AudioSegment.silent(duration=300)
        
        combined.export(output_file, format="mp3")
        print(f"✓ Combined audio saved to {output_file}")
        return True
    except ImportError:
        print("⚠ pydub not available, using simple concatenation")
        # Simple file concatenation (not ideal but works)
        with open(output_file, 'wb') as outfile:
            for file in segment_files:
                if os.path.exists(file):
                    with open(file, 'rb') as infile:
                        outfile.write(infile.read())
        return True
    except Exception as e:
        print(f"✗ Audio combination failed: {e}")
        return False

def main():
    import argparse
    parser = argparse.ArgumentParser(description='Generate TTS from SRT file')
    parser.add_argument('--srt', required=True, help='Input SRT file')
    parser.add_argument('--out', required=True, help='Output audio file')
    args = parser.parse_args()
    
    # Get API credentials from environment
    api_key = os.getenv('ELEVENLABS_API_KEY')
    voice_id = os.getenv('ELEVENLABS_VOICE_ID')
    
    use_elevenlabs = api_key and voice_id
    
    if use_elevenlabs:
        print(f"🎙️ Using ElevenLabs TTS (Voice: {voice_id[:8]}...)")
    else:
        print("🎙️ Using gTTS (free fallback)")
    
    # Parse SRT
    segments = parse_srt(args.srt)
    print(f"📝 Found {len(segments)} segments in SRT")
    
    # Generate audio for each segment
    segment_files = []
    temp_dir = Path("temp_audio_segments")
    temp_dir.mkdir(exist_ok=True)
    
    for i, segment in enumerate(segments):
        segment_file = temp_dir / f"segment_{i:03d}.mp3"
        segment_files.append(str(segment_file))
        
        success = False
        if use_elevenlabs:
            success = generate_elevenlabs_tts(
                segment['text'], 
                api_key, 
                voice_id, 
                str(segment_file)
            )
            time.sleep(0.3)  # Rate limiting
        
        if not success:
            # Fallback to gTTS
            success = generate_gtts_fallback(segment['text'], str(segment_file))
        
        if not success:
            print(f"⚠ Skipping segment {i}")
    
    # Combine all segments
    print("\n🔗 Combining audio segments...")
    combine_audio_segments(segment_files, args.out)
    
    # Cleanup temp files
    import shutil
    shutil.rmtree(temp_dir, ignore_errors=True)
    
    print(f"\n✅ Final audio: {args.out}")
    
    # Output JSON summary
    result = {
        "srt_file": args.srt,
        "output_file": args.out,
        "segments_processed": len(segments),
        "tts_provider": "ElevenLabs" if use_elevenlabs else "gTTS",
        "status": "success"
    }
    print(f"\n{json.dumps(result, indent=2)}")

if __name__ == "__main__":
    main()
