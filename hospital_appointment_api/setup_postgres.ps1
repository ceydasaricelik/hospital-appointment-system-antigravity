# PostgreSQL Setup Script for Windows
# This script attempts to set up PostgreSQL with the correct password

$PG_BIN = "C:\Program Files\PostgreSQL\18\bin"
$env:PATH += ";$PG_BIN"

Write-Host "Setting up PostgreSQL for Hospital Appointment System..."

# Try common passwords
$passwords = @("password", "postgres", "admin", "root", "")

foreach ($pwd in $passwords) {
    Write-Host "Trying password: '$pwd'..."
    $env:PGPASSWORD = $pwd
    
    # Test connection
    $result = & "$PG_BIN\psql.exe" -U postgres -h 127.0.0.1 -c "SELECT 1;" 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully connected with password: '$pwd'" -ForegroundColor Green
        
        # Create database.yml content
        $content = @"
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres
  password: $pwd
  host: 127.0.0.1
  port: 5432

development:
  <<: *default
  database: hospital_appointment_api_development

test:
  <<: *default
  database: hospital_appointment_api_test

production:
  primary: &primary_production
    <<: *default
    database: hospital_appointment_api_production
  cache:
    <<: *primary_production
    database: hospital_appointment_api_production_cache
    migrations_paths: db/cache_migrate
  queue:
    <<: *primary_production
    database: hospital_appointment_api_production_queue
    migrations_paths: db/queue_migrate
  cable:
    <<: *primary_production
    database: hospital_appointment_api_production_cable
    migrations_paths: db/cable_migrate
"@
        
        Set-Content -Path "config/database.yml" -Value $content
        Write-Host "Updated config/database.yml" -ForegroundColor Green
        
        # Set environment variable for this session
        $env:PGPASSWORD = $pwd
        
        exit 0
    }
}

Write-Host "Could not connect to PostgreSQL with any common password." -ForegroundColor Red
Write-Host "Please ensure PostgreSQL is running."
exit 1
