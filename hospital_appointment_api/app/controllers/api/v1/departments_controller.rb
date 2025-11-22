module Api
  module V1
    class DepartmentsController < ApplicationController
      before_action :authenticate_user!

      def index
        departments = Department.all
        render json: departments
      end

      def show
        department = Department.find(params[:id])
        render json: department
      end
    end
  end
end
