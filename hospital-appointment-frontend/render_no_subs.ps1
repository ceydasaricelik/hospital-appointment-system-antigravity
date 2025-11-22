# Final Video Render Script - NO SUBTITLES (audio only)
$VideoInput = "cypress/videos/full_demo.feature.mp4"
$AudioInput = "hospital_demo_full_narration.mp3"
$OutputFile = "hospital_demo_final_no_subs.mp4"

Write-Host "Hospital Management System - Final Video Render (No Subtitles)" -ForegroundColor Cyan

# Check inputs
if (-not (Test-Path $VideoInput)) {
    Write-Error "Video file not found: $VideoInput"
    exit 1
}

if (-not (Test-Path $AudioInput)) {
    Write-Error "Audio file not found: $AudioInput"
    exit 1
}

Write-Host "Video: $VideoInput" -ForegroundColor Green
Write-Host "Audio: $AudioInput" -ForegroundColor Green

# Merge video + audio (NO subtitles)
Write-Host "`nMerging video and audio (no subtitles)..." -ForegroundColor Yellow

& ffmpeg -y -i $VideoInput -i $AudioInput -c:v copy -c:a aac -b:a 192k -map 0:v:0 -map 1:a:0 -shortest $OutputFile

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to merge video and audio"
    exit 1
}

Write-Host "Video created successfully (no subtitles)" -ForegroundColor Green

# Get file info
$FileInfo = Get-Item $OutputFile
$FileSizeMB = [math]::Round($FileInfo.Length / 1MB, 2)

Write-Host "`nSUCCESS! Final video created" -ForegroundColor Green
Write-Host "Output: $OutputFile" -ForegroundColor White
Write-Host "Size: $FileSizeMB MB" -ForegroundColor White
Write-Host "Features: Audio narration only (no subtitles)" -ForegroundColor White

# Output JSON
$Summary = @{
    video = $VideoInput
    audio = $AudioInput
    final = $OutputFile
    size_mb = $FileSizeMB
    subtitles = "none"
    status = "success"
}

Write-Host "`nSummary:" -ForegroundColor Cyan
$Summary | ConvertTo-Json | Write-Host
