import json
import sys
import argparse
from pathlib import Path

def create_srt_from_steps():
    """Create SRT file from predefined demo steps"""
    
    # Define demo steps with approximate timings
    steps = [
        {"start": "00:00:01,000", "end": "00:00:04,000", "text": "Opening the hospital appointment system login page."},
        {"start": "00:00:04,000", "end": "00:00:07,000", "text": "Filling in the email address for patient login."},
        {"start": "00:00:07,000", "end": "00:00:10,000", "text": "Entering the password securely."},
        {"start": "00:00:10,000", "end": "00:00:13,000", "text": "Submitting the login form to authenticate."},
        {"start": "00:00:13,000", "end": "00:00:16,000", "text": "Login successful. Redirecting to patient dashboard."},
        {"start": "00:00:16,000", "end": "00:00:19,000", "text": "Viewing current appointments on the dashboard."},
        {"start": "00:00:19,000", "end": "00:00:22,000", "text": "Clicking on Book New Appointment button."},
        {"start": "00:00:22,000", "end": "00:00:25,000", "text": "Selecting the medical department from dropdown."},
        {"start": "00:00:25,000", "end": "00:00:28,000", "text": "Choosing an available doctor for the appointment."},
        {"start": "00:00:28,000", "end": "00:00:31,000", "text": "Picking the appointment date and time."},
        {"start": "00:00:31,000", "end": "00:00:34,000", "text": "Submitting the appointment booking form."},
        {"start": "00:00:34,000", "end": "00:00:37,000", "text": "Appointment created successfully. Returning to dashboard."},
        {"start": "00:00:37,000", "end": "00:00:40,000", "text": "Verifying the new appointment appears in the list."},
    ]
    
    return steps

def generate_srt(steps, output_file):
    """Generate SRT file from steps"""
    srt_content = []
    
    for i, step in enumerate(steps, 1):
        srt_content.append(str(i))
        srt_content.append(f"{step['start']} --> {step['end']}")
        srt_content.append(step['text'])
        srt_content.append("")  # Empty line between entries
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(srt_content))
    
    print(f"✅ SRT file created: {output_file}")
    print(f"📝 Total segments: {len(steps)}")
    
    return len(steps)

def main():
    parser = argparse.ArgumentParser(description='Create SRT from Cypress demo steps')
    parser.add_argument('--video', help='Input video file (for reference)')
    parser.add_argument('--out', required=True, help='Output SRT file')
    args = parser.parse_args()
    
    print("🎬 Creating SRT subtitles for hospital appointment demo...")
    
    steps = create_srt_from_steps()
    segment_count = generate_srt(steps, args.out)
    
    # Output summary
    result = {
        "srt_file": args.out,
        "segments": segment_count,
        "status": "success"
    }
    print(f"\n{json.dumps(result, indent=2)}")

if __name__ == "__main__":
    main()
