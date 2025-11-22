module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :authenticate_user!

      def index
        if current_user.role == 'patient'
          appointments = current_user.patient.appointments.includes(:doctor, :department)
        elsif current_user.role == 'doctor'
          appointments = current_user.doctor.appointments.includes(:patient, :department)
        else
          appointments = Appointment.all
        end
        render json: appointments, include: [:doctor, :department, :patient]
      end

      def create
        if current_user.role != 'patient'
          return render json: { error: 'Only patients can book appointments' }, status: :forbidden
        end

        appointment = current_user.patient.appointments.build(appointment_params)
        # Default status
        appointment.status = 'scheduled'
        
        if appointment.save
          render json: appointment, status: :created
        else
          render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        appointment = Appointment.find(params[:id])
        
        if current_user.role == 'patient' && appointment.patient_id != current_user.patient.id
           return render json: { error: 'Forbidden' }, status: :forbidden
        end
        
        if appointment.update(update_params)
          render json: appointment
        else
          render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        appointment = Appointment.find(params[:id])
         if current_user.role == 'patient' && appointment.patient_id != current_user.patient.id
           return render json: { error: 'Forbidden' }, status: :forbidden
        end
        
        appointment.destroy
        head :no_content
      end

      private

      def appointment_params
        params.permit(:doctor_id, :department_id, :scheduled_at)
      end

      def update_params
        params.permit(:status)
      end
    end
  end
end
