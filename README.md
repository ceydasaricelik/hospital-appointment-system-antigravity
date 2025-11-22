# 🏥 Hospital Appointment Management System

A full-stack hospital appointment management system built with **Rails 8 API** backend and **React (Vite)** frontend, featuring comprehensive testing, automated demo video generation, and professional UI/UX design.

##[Demo Video] https://youtu.be/8VWnvhlfwjI

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [API Documentation](#api-documentation)
- [Testing](#testing)
- [Demo Video Pipeline](#demo-video-pipeline)
- [Project Structure](#project-structure)
- [Contributing](#contributing)

---

## 🎯 Overview

This project is a complete hospital management solution that allows patients to:

- Register and authenticate securely
- View their appointment history
- Book new appointments with doctors
- Select departments and available doctors
- Choose appointment dates and times

The system includes a **production-ready demo video** with synchronized narration, showcasing the complete user journey from login to appointment booking.

---

## ✨ Features

### Backend (Rails 8 API)

- ✅ **RESTful API** with JWT authentication
- ✅ **PostgreSQL** database with ActiveRecord ORM
- ✅ **Role-based access control** (Patient, Doctor, Admin)
- ✅ **CORS configuration** for frontend integration
- ✅ **Comprehensive test suite** (RSpec + Cucumber)
- ✅ **Factory Bot** for test data generation
- ✅ **Seed data** for quick setup

### Frontend (React + Vite)

- ✅ **Modern React** with TypeScript support
- ✅ **React Router** for client-side navigation
- ✅ **Axios** for API communication with JWT interceptor
- ✅ **Context API** for authentication state management
- ✅ **Responsive design** with centered, professional layout
- ✅ **Clean, minimal UI** with white boxes and organized forms

### Testing & Quality Assurance

- ✅ **RSpec** unit and request specs
- ✅ **Cucumber** BDD feature tests
- ✅ **Cypress** end-to-end testing
- ✅ **Factory Bot** for test fixtures
- ✅ **Database Cleaner** for test isolation

### Demo Video Pipeline

- ✅ **Automated Cypress recording** of user flows
- ✅ **Text-to-Speech narration** (ElevenLabs API + gTTS fallback)
- ✅ **SRT subtitle generation** from test steps
- ✅ **FFmpeg video rendering** with synchronized audio
- ✅ **Production-ready demo** (60 seconds, perfectly synced)

---

## 🛠️ Tech Stack

### Backend

- **Framework**: Ruby on Rails 8.0.4 (API mode)
- **Database**: PostgreSQL 18
- **Authentication**: JWT (JSON Web Tokens)
- **Testing**: RSpec, Cucumber, FactoryBot
- **Ruby Version**: 3.3.9

### Frontend

- **Framework**: React 18 with Vite
- **Language**: JavaScript/TypeScript
- **Routing**: React Router DOM
- **HTTP Client**: Axios
- **Testing**: Cypress 15.7.0
- **Styling**: Custom CSS (minimal, centered design)

### DevOps & Tools

- **Video Processing**: FFmpeg 8.0
- **TTS**: ElevenLabs API / Google TTS (gTTS)
- **Audio Processing**: pydub (Python)
- **Package Managers**: Bundler (Ruby), npm (Node.js), pip (Python)

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     React Frontend                          │
│  (Vite + React Router + Axios + Auth Context)              │
└────────────────────┬────────────────────────────────────────┘
                     │ HTTP/JSON (JWT)
                     │
┌────────────────────▼────────────────────────────────────────┐
│                   Rails 8 API Backend                       │
│  (JWT Auth + CORS + RESTful Endpoints)                     │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│                  PostgreSQL Database                        │
│  (Users, Patients, Doctors, Departments, Appointments)     │
└─────────────────────────────────────────────────────────────┘
```

### Database Schema

```
Users
├── id, email, password_digest, role
├── has_one :patient
└── has_one :doctor

Patients
├── id, user_id, first_name, last_name, date_of_birth
└── has_many :appointments

Doctors
├── id, user_id, department_id, first_name, last_name, specialization
└── has_many :appointments

Departments
├── id, name, description
└── has_many :doctors

Appointments
├── id, patient_id, doctor_id, department_id, appointment_date, status
├── belongs_to :patient
├── belongs_to :doctor
└── belongs_to :department
```

---

## 🚀 Getting Started

### Prerequisites

- **Ruby** 3.3.9+
- **Rails** 8.0.4+
- **PostgreSQL** 18+
- **Node.js** 18+ and npm
- **Python** 3.12+ (for TTS generation)
- **FFmpeg** 8.0+ (for video rendering)

### Backend Setup

```bash
cd hospital_appointment_api

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Start server
rails s -p 3000
```

The API will be available at `http://localhost:3000`

### Frontend Setup

```bash
cd hospital-appointment-frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

The frontend will be available at `http://localhost:5173`

### Test Credentials

After running `rails db:seed`, use these credentials:

- **Email**: `patient@example.com`
- **Password**: `password123`

---

## 📡 API Documentation

### Authentication Endpoints

#### Register

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "email": "patient@example.com",
  "password": "password123",
  "role": "patient",
  "first_name": "John",
  "last_name": "Doe",
  "date_of_birth": "1990-01-01"
}
```

#### Login

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "patient@example.com",
  "password": "password123"
}

Response:
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": { "id": 1, "email": "patient@example.com", "role": "patient" }
}
```

#### Get Current User

```http
GET /api/v1/auth/me
Authorization: Bearer <token>
```

### Resource Endpoints

#### Departments

```http
GET /api/v1/departments
GET /api/v1/departments/:id
```

#### Doctors

```http
GET /api/v1/doctors
GET /api/v1/doctors/:id
```

#### Appointments

```http
GET /api/v1/appointments
POST /api/v1/appointments
PUT /api/v1/appointments/:id
DELETE /api/v1/appointments/:id
```

---

## 🧪 Testing

### Backend Tests

```bash
cd hospital_appointment_api

# Run RSpec tests
bundle exec rspec

# Run Cucumber features
bundle exec cucumber

# Run specific test
bundle exec rspec spec/requests/auth_spec.rb
```

### Frontend Tests

```bash
cd hospital-appointment-frontend

# Run Cypress tests (headless)
npx cypress run

# Open Cypress GUI
npx cypress open

# Run specific test
npx cypress run --spec "cypress/e2e/production_demo.cy.js"
```

---

## 🎬 Demo Video Pipeline

The project includes an automated demo video generation pipeline:

### 1. Generate Narration Audio

```bash
cd hospital-appointment-frontend

# Set environment variables (optional, falls back to gTTS)
$env:ELEVENLABS_API_KEY = "your_api_key"
$env:ELEVENLABS_VOICE_ID = "your_voice_id"

# Generate TTS from SRT file
python generate_audio_advanced.py --srt hospital_demo_production.srt --out narration.mp3
```

### 2. Record Cypress Test

```bash
# Run Cypress test with video recording
npx cypress run --spec "cypress/e2e/production_demo.cy.js"

# Video saved to: cypress/videos/production_demo.cy.js.mp4
```

### 3. Render Final Video

```bash
# Combine video + audio (no subtitles)
ffmpeg -y -i cypress/videos/production_demo.cy.js.mp4 \
       -i narration.mp3 \
       -c:v copy -c:a aac -b:a 192k \
       -map 0:v:0 -map 1:a:0 -shortest \
       HOSPITAL_DEMO_FINAL.mp4
```

### Demo Video Features

- ✅ **60-second duration** (15 segments × 4 seconds)
- ✅ **Perfect audio-video synchronization**
- ✅ **Professional narration** (ElevenLabs or gTTS)
- ✅ **Complete user journey** (Login → Dashboard → Booking → Success)
- ✅ **Production-ready quality**

---

## 📁 Project Structure

```
hospital-appointment-system/
├── hospital_appointment_api/          # Rails 8 API Backend
│   ├── app/
│   │   ├── controllers/
│   │   │   ├── application_controller.rb
│   │   │   ├── concerns/
│   │   │   │   └── authenticatable.rb
│   │   │   └── api/v1/
│   │   │       ├── auth_controller.rb
│   │   │       ├── departments_controller.rb
│   │   │       ├── doctors_controller.rb
│   │   │       └── appointments_controller.rb
│   │   ├── models/
│   │   │   ├── user.rb
│   │   │   ├── patient.rb
│   │   │   ├── doctor.rb
│   │   │   ├── department.rb
│   │   │   └── appointment.rb
│   │   └── services/
│   │       └── json_web_token.rb
│   ├── config/
│   │   ├── database.yml
│   │   ├── routes.rb
│   │   └── initializers/
│   │       └── cors.rb
│   ├── db/
│   │   ├── migrate/
│   │   └── seeds.rb
│   ├── spec/                          # RSpec tests
│   │   ├── factories/
│   │   └── requests/
│   ├── features/                      # Cucumber features
│   │   └── step_definitions/
│   └── Gemfile
│
├── hospital-appointment-frontend/     # React Frontend
│   ├── src/
│   │   ├── api/
│   │   │   └── axios.ts
│   │   ├── context/
│   │   │   └── AuthContext.tsx
│   │   ├── pages/
│   │   │   ├── Login.tsx
│   │   │   ├── Dashboard.tsx
│   │   │   └── Booking.tsx
│   │   ├── App.tsx
│   │   ├── App.css
│   │   └── main.tsx
│   ├── cypress/
│   │   ├── e2e/
│   │   │   └── production_demo.cy.js
│   │   ├── support/
│   │   │   ├── commands.ts
│   │   │   └── e2e.ts
│   │   └── videos/                    # Recorded test videos
│   ├── scripts/
│   │   └── create_srt_from_cypress_logs.py
│   ├── generate_audio_advanced.py     # TTS generator
│   ├── hospital_demo_production.srt   # Narration script
│   ├── HOSPITAL_DEMO_FINAL.mp4        # Final demo video
│   ├── package.json
│   └── cypress.config.ts
│
└── README.md                          # This file
```

---

## 🎨 UI/UX Design Principles

### Layout

- **Centered design**: All content boxes centered on the page
- **Title above box**: Page titles positioned above white boxes
- **Consistent spacing**: 2.5rem padding, 8px border radius
- **White boxes on gray background**: Clean, professional look

### Typography

- **Font**: Inter (Google Fonts)
- **Weights**: 400 (regular), 500 (medium), 600 (semibold), 700 (bold)
- **Sizes**: 0.875rem - 2rem (responsive)

### Colors

- **Background**: #f5f5f5 (light gray)
- **Boxes**: #ffffff (white)
- **Borders**: #e0e0e0 (light gray)
- **Primary**: #333 (dark gray/black)
- **Text**: #333 (headings), #666 (body), #444 (labels)

### Components

- **Buttons**: Full-width, 1rem padding, 6px radius
- **Inputs**: 0.875rem padding, 1px border, 6px radius
- **Cards**: White background, subtle shadow, 8px radius

---

## 🔒 Security Features

- ✅ **JWT Authentication** with secure token storage
- ✅ **Password hashing** using bcrypt
- ✅ **CORS configuration** for controlled access
- ✅ **Role-based authorization** (Patient, Doctor, Admin)
- ✅ **Protected routes** on frontend
- ✅ **API request interceptors** for automatic token injection

---

## 📊 Performance Optimizations

- ✅ **API-only Rails** (no view rendering overhead)
- ✅ **Vite** for fast frontend builds
- ✅ **Lazy loading** with React Router
- ✅ **Axios interceptors** for efficient token management
- ✅ **Database indexing** on foreign keys and email

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👥 Authors

- **Halide Ceyda Sarıçelik** -

---

**Special thanks to Nurettin Şenyer and Ömer Durmuş for their guidance and support throughout the project.**

## 🙏 Acknowledgments

- Rails community for excellent documentation
- React and Vite teams for modern tooling
- Cypress for reliable E2E testing
- ElevenLabs for high-quality TTS
- FFmpeg for video processing capabilities

---
