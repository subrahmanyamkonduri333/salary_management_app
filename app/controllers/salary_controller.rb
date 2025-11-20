class SalaryController < ApplicationController
  def calculate
    employee = Employee.find(params[:employee_id])
    gross = params[:gross].to_i

    result = SalaryCalculator.calculate(employee, gross)

    render json: {
      employee_id: employee.id,
      gross: gross,
      tds: result[:tds],
      net: result[:net]
    }, status: :ok
  end
end
