# Setup Instructions

## Backend (Rails API)

### Prerequisites
- Ruby 3.2.x
- PostgreSQL
- Rails 8.x

### Setup
1. Navigate to `hospital_appointment_api` directory.
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Configure Database:
   - The `config/database.yml` is configured to use environment variables `POSTGRES_USER` and `POSTGRES_PASSWORD`.
   - Ensure your PostgreSQL server is running.
   - Set the environment variables or update `config/database.yml` with your credentials.
4. Create and Migrate Database:
   ```bash
   rails db:create
   rails db:migrate
   ```
5. Start Server:
   ```bash
   rails s
   ```

## Frontend (React)
(To be implemented)

## Testing
- Run RSpec: `bundle exec rspec`
- Run Cucumber: `bundle exec cucumber`
