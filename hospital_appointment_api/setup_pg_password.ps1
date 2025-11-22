# PostgreSQL Password Reset and Setup Script
# This script will set postgres user password to 1234

$PG_BIN = "C:\Program Files\PostgreSQL\18\bin"
$PASSWORD = "1234"

Write-Host "PostgreSQL Setup for Hospital Appointment System" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan

# Try to find pg_hba.conf
$pgHbaLocations = @(
    "C:\Program Files\PostgreSQL\18\data\pg_hba.conf",
    "C:\PostgreSQL\18\data\pg_hba.conf",
    "$env:PROGRAMDATA\PostgreSQL\18\data\pg_hba.conf"
)

$pgHbaPath = $null
foreach ($loc in $pgHbaLocations) {
    if (Test-Path $loc) {
        $pgHbaPath = $loc
        Write-Host "Found pg_hba.conf at: $loc" -ForegroundColor Green
        break
    }
}

if ($pgHbaPath) {
    Write-Host "`nBacking up pg_hba.conf..." -ForegroundColor Yellow
    Copy-Item $pgHbaPath "$pgHbaPath.backup" -Force
    
    # Read current content
    $content = Get-Content $pgHbaPath
    
    # Add trust authentication for local connections
    $newContent = @"
# Temporary trust authentication for setup
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
local   all             all                                     trust

"@
    
    # Prepend trust rules
    $newContent + ($content -join "`n") | Set-Content $pgHbaPath
    
    Write-Host "Updated pg_hba.conf with trust authentication" -ForegroundColor Green
    Write-Host "Please restart PostgreSQL service manually" -ForegroundColor Yellow
} else {
    Write-Host "Could not find pg_hba.conf" -ForegroundColor Red
    Write-Host "PostgreSQL may not be properly installed or initialized" -ForegroundColor Red
}

Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Restart PostgreSQL service (from Services or pgAdmin)" -ForegroundColor White
Write-Host "2. Run this command to set password:" -ForegroundColor White
Write-Host "   & '$PG_BIN\psql.exe' -U postgres -h 127.0.0.1 -c `"ALTER USER postgres PASSWORD '1234';`"" -ForegroundColor Yellow
