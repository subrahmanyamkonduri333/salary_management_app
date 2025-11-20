class MetricsController < ApplicationController
  def salary_by_country
    return render json: { error: "country required" }, status: :bad_request if params[:country].blank?

    employees = Employee.where(country: params[:country])

    stats = {
      min: employees.minimum(:salary),
      max: employees.maximum(:salary),
      avg: employees.average(:salary)&.to_f
    }

    render json: stats
  end

  def salary_by_job_title
    return render json: { error: "job_title required" }, status: :bad_request if params[:job_title].blank?
    employees = Employee.where(job_title: params[:job_title])

    render json: {
      avg: employees.average(:salary)&.to_f
    }
  end
end
