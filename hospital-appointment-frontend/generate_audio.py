import re
from gtts import gTTS
import os

def parse_srt(srt_file):
    with open(srt_file, 'r') as f:
        content = f.read()
    
    # Simple regex to find text blocks
    blocks = re.split(r'\n\n', content.strip())
    text_segments = []
    for block in blocks:
        lines = block.split('\n')
        if len(lines) >= 3:
            text = ' '.join(lines[2:])
            text_segments.append(text)
    return " ".join(text_segments)

def generate_audio(text, output_file):
    print(f"Generating audio for: {text}")
    tts = gTTS(text=text, lang='en')
    tts.save(output_file)
    print(f"Audio saved to {output_file}")

if __name__ == "__main__":
    srt_path = "hospital_demo.srt"
    output_path = "hospital_demo_narration.mp3"
    
    if not os.path.exists(srt_path):
        print(f"Error: {srt_path} not found.")
    else:
        full_text = parse_srt(srt_path)
        generate_audio(full_text, output_path)
