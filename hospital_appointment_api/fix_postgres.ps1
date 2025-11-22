# PostgreSQL Repair Script
$ErrorActionPreference = "Stop"

$PG_HOME = "C:\Program Files\PostgreSQL\18"
$PG_BIN = "$PG_HOME\bin"
$PG_DATA = "$PSScriptRoot\postgres_data"
$PG_SVC_NAME = "postgresql-x64-18"
$PASSWORD = "1234"

Write-Host "Starting PostgreSQL Repair..."

# 1. Stop and Remove existing service if any
Write-Host "Stopping existing service..."
try {
    Stop-Service -Name $PG_SVC_NAME -Force -ErrorAction SilentlyContinue
    & "$PG_BIN\pg_ctl.exe" unregister -N $PG_SVC_NAME
} catch {
    Write-Host "Service cleanup skipped or failed (might not exist)."
}

# Stop process if running locally
Write-Host "Stopping local postgres process..."
& "$PG_BIN\pg_ctl.exe" stop -D "$PG_DATA" -m fast
Start-Sleep -Seconds 3

# 2. Clean up data directory
if (Test-Path $PG_DATA) {
    Write-Host "Removing existing data directory to ensure clean slate..."
    Remove-Item -Path $PG_DATA -Recurse -Force
}

# 3. Initialize Data Cluster
Write-Host "Initializing data cluster..."
$pwFile = "$PSScriptRoot\pg_pass.txt"
$PASSWORD | Out-File -FilePath $pwFile -Encoding ASCII

& "$PG_BIN\initdb.exe" -U postgres -A password --pwfile "$pwFile" -E UTF8 -D "$PG_DATA" --locale=C

if ($LASTEXITCODE -ne 0) {
    Write-Error "initdb failed!"
}
Remove-Item $pwFile

# 4. Configure PostgreSQL
Write-Host "Configuring postgresql.conf and pg_hba.conf..."
$confFile = "$PG_DATA\postgresql.conf"
$hbaFile = "$PG_DATA\pg_hba.conf"

# Enable TCP/IP
Add-Content -Path $confFile -Value "`nlisten_addresses = '*'"
Add-Content -Path $confFile -Value "port = 5432"

# Configure Auth
$hbaContent = @"
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
local   all             all                                     trust
"@
Set-Content -Path $hbaFile -Value $hbaContent

# 5. Start Server (Process mode, since Service registration failed)
Write-Host "Starting PostgreSQL server..."
& "$PG_BIN\pg_ctl.exe" start -D "$PG_DATA" -l "$PG_DATA\logfile.log"


# 6. Verify Connection
Write-Host "Verifying connection..."
Start-Sleep -Seconds 5
$env:PGPASSWORD = $PASSWORD
& "$PG_BIN\psql.exe" -U postgres -h 127.0.0.1 -c "SELECT version();"

if ($LASTEXITCODE -eq 0) {
    Write-Host "PostgreSQL is successfully running!" -ForegroundColor Green
} else {
    Write-Error "Failed to connect to PostgreSQL."
}
