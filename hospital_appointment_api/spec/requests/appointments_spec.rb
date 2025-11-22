require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  let(:patient_user) { create(:user, :patient) }
  let!(:patient) { create(:patient, user: patient_user) }
  let(:doctor_user) { create(:user, :doctor) }
  let(:department) { create(:department) }
  let!(:doctor) { create(:doctor, user: doctor_user, department: department) }
  let(:token) { JsonWebToken.encode(user_id: patient_user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }

  describe 'GET /api/v1/appointments' do
    it 'returns list of appointments' do
      create(:appointment, patient: patient, doctor: doctor, department: department)
      
      get '/api/v1/appointments', headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
    
    it 'returns unauthorized without token' do
      get '/api/v1/appointments'
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /api/v1/appointments' do
    let(:valid_attributes) do
      {
        doctor_id: doctor.id,
        department_id: department.id,
        scheduled_at: Time.now + 1.day
      }
    end

    it 'creates a new appointment' do
      expect {
        post '/api/v1/appointments', params: valid_attributes.to_json, headers: headers
      }.to change(Appointment, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end
end
