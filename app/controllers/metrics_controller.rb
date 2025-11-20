class MetricsController < ApplicationController
  def salary_by_country
    employees = Employee.where(country: params[:country])

    stats = {
      min: employees.minimum(:salary),
      max: employees.maximum(:salary),
      avg: employees.average(:salary)&.to_f
    }

    render json: stats
  end

  def salary_by_job_title
    employees = Employee.where(job_title: params[:job_title])

    render json: {
      avg: employees.average(:salary)&.to_f
    }
  end
end
