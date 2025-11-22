require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user, password: 'password123') }
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'POST /api/v1/auth/login' do
    context 'with valid credentials' do
      it 'returns a token and user info' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'password123' }.to_json, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['token']).to be_present
        expect(json['user']['email']).to eq(user.email)
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'wrongpassword' }.to_json, headers: headers

        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body)
        expect(json['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'POST /api/v1/auth/register' do
    let(:valid_attributes) do
      {
        email: 'newpatient@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        role: 'patient',
        first_name: 'John',
        last_name: 'Doe',
        date_of_birth: '1990-01-01'
      }
    end

    context 'with valid attributes' do
      it 'creates a new user and patient' do
        expect {
          post '/api/v1/auth/register', params: valid_attributes.to_json, headers: headers
        }.to change(User, :count).by(1).and change(Patient, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end
end
