class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @employee, status: :ok
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.permit(:full_name, :job_title, :country, :salary)
  end
end
