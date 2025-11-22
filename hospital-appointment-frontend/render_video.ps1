# PowerShell script to render the final video

$VideoInput = "cypress/videos/demo.feature.mp4" 
# Check if e2e folder exists in path (Cypress 10+ structure varies)
if (Test-Path "cypress/videos/e2e/demo.feature.mp4") {
    $VideoInput = "cypress/videos/e2e/demo.feature.mp4"
}

$AudioInput = "hospital_demo_narration.mp3"
$SrtInput = "hospital_demo.srt"
$OutputVoiced = "hospital_demo_voiced.mp4"
$OutputSubtitled = "hospital_demo_with_subtitles.mp4"

Write-Host "Checking for input files..."
Write-Host "Video Input: $VideoInput"

if (-not (Test-Path $VideoInput)) {
    Write-Error "Video file not found at $VideoInput. Run Cypress tests first."
    exit 1
}

if (-not (Test-Path $AudioInput)) {
    Write-Error "Audio file not found at $AudioInput. Run generate_audio.py first."
    exit 1
}

# Escape path for subtitles filter
# FFmpeg requires escaping backslashes and colons in filter paths on Windows
# But since we are in the same directory, relative path usually works best.
# We will use relative path.

Write-Host "Rendering voiced video..."
# Remove -shortest to allow video to play fully if it's longer than audio (due to waits)
# Or keep it if we want to cut video when audio ends. 
# Given we added explicit waits, video might be longer. Let's keep both streams fully.
ffmpeg -y -i $VideoInput -i $AudioInput -c:v copy -c:a aac $OutputVoiced

if ($LASTEXITCODE -eq 0) {
    Write-Host "Voiced video created: $OutputVoiced"
} else {
    Write-Error "FFmpeg failed to create voiced video."
    exit 1
}

Write-Host "Rendering subtitled video..."
# Use forward slashes for subtitle path to avoid escaping issues
ffmpeg -y -i $OutputVoiced -vf "subtitles=$SrtInput" -c:a copy $OutputSubtitled

if ($LASTEXITCODE -eq 0) {
    Write-Host "Subtitled video created: $OutputSubtitled"
} else {
    Write-Error "FFmpeg failed to create subtitled video."
}
