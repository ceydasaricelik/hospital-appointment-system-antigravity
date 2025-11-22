module Api
  module V1
    class DoctorsController < ApplicationController
      before_action :authenticate_user!

      def index
        doctors = Doctor.includes(:department).all
        render json: doctors, include: :department
      end

      def show
        doctor = Doctor.find(params[:id])
        render json: doctor, include: :department
      end
    end
  end
end
