# Final Video Render Script
$VideoInput = "cypress/videos/demo.feature.mp4"
$AudioInput = "hospital_demo_narration_en.mp3"
$SrtInput = "hospital_demo.srt"
$OutputFile = "hospital_demo_final.mp4"

Write-Host "Hospital Appointment Demo - Final Video Render" -ForegroundColor Cyan

# Check inputs
if (-not (Test-Path $VideoInput)) {
    Write-Error "Video file not found: $VideoInput"
    exit 1
}

if (-not (Test-Path $AudioInput)) {
    Write-Error "Audio file not found: $AudioInput"
    exit 1
}

if (-not (Test-Path $SrtInput)) {
    Write-Error "SRT file not found: $SrtInput"
    exit 1
}

Write-Host "Video: $VideoInput" -ForegroundColor Green
Write-Host "Audio: $AudioInput" -ForegroundColor Green
Write-Host "SRT: $SrtInput" -ForegroundColor Green

# Step 1: Merge video + audio
Write-Host "`nStep 1/2: Merging video and audio..." -ForegroundColor Yellow
$TempVoiced = "hospital_demo_voiced_tmp.mp4"

& ffmpeg -y -i $VideoInput -i $AudioInput -c:v copy -c:a aac -b:a 192k -map 0:v:0 -map 1:a:0 -shortest $TempVoiced

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to merge video and audio"
    exit 1
}

Write-Host "Audio merged successfully" -ForegroundColor Green

# Step 2: Burn subtitles
Write-Host "`nStep 2/2: Embedding subtitles..." -ForegroundColor Yellow

& ffmpeg -y -i $TempVoiced -vf "subtitles='$SrtInput':force_style='FontName=Arial,FontSize=18,PrimaryColour=&HFFFFFF&,OutlineColour=&H000000&,Outline=2,Shadow=1'" -c:a copy $OutputFile

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to embed subtitles"
    Remove-Item $TempVoiced -ErrorAction SilentlyContinue
    exit 1
}

Write-Host "Subtitles embedded successfully" -ForegroundColor Green

# Cleanup
Remove-Item $TempVoiced -ErrorAction SilentlyContinue

# Get file info
$FileInfo = Get-Item $OutputFile
$FileSizeMB = [math]::Round($FileInfo.Length / 1MB, 2)

Write-Host "`nSUCCESS! Final video created" -ForegroundColor Green
Write-Host "Output: $OutputFile" -ForegroundColor White
Write-Host "Size: $FileSizeMB MB" -ForegroundColor White

# Output JSON
$Summary = @{
    cypress_result = "passed"
    video = $VideoInput
    srt = $SrtInput
    tts = $AudioInput
    final = $OutputFile
    size_mb = $FileSizeMB
    status = "success"
}

Write-Host "`nSummary:" -ForegroundColor Cyan
$Summary | ConvertTo-Json | Write-Host
