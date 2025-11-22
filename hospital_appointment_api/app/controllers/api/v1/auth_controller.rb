module Api
  module V1
    class AuthController < ApplicationController
      def register
        user = User.new(user_params)
        if user.save
          # Create patient profile if role is patient
          if user.role == 'patient'
            user.create_patient!(patient_params)
          end
          
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user_response(user) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user_response(user) }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def me
        authenticate_user!
        render json: user_response(@current_user)
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation, :role)
      end

      def patient_params
        params.permit(:first_name, :last_name, :date_of_birth)
      end

      def user_response(user)
        user.as_json(only: [:id, :email, :role]).merge(
          profile: user.patient || user.doctor
        )
      end
    end
  end
end
