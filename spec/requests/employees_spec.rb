require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:valid_params) { attributes_for(:employee) }

  describe "POST /employees" do
    it "creates an employee with valid params" do
      post "/employees", params: valid_params

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["full_name"]).to eq(valid_params[:full_name])
    end

    it "returns 422 for missing required fields" do
      post "/employees", params: { full_name: nil, job_title: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body["errors"]).to be_present
    end

    it "rejects non-numeric salary" do
      post "/employees", params: valid_params.merge(salary: "BAD")

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /employees/:id" do
    it "returns an employee" do
      employee = create(:employee)
      get "/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(employee.id)
    end

    it "returns 404 for non-existing employee" do
      get "/employees/999999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /employees/:id" do
    let!(:employee) { create(:employee) }

    it "updates an employee" do
      put "/employees/#{employee.id}", params: { job_title: "Architect" }

      expect(response).to have_http_status(:ok)
      expect(employee.reload.job_title).to eq("Architect")
    end

    it "returns 422 when invalid" do
      put "/employees/#{employee.id}", params: { salary: -500 }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /employees/:id" do
    let!(:employee) { create(:employee) }

    it "deletes an employee" do
      delete "/employees/#{employee.id}"

      expect(response).to have_http_status(:no_content)
      expect(Employee.find_by(id: employee.id)).to be_nil
    end

    it "returns 404 when deleting missing employee" do
      delete "/employees/999999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
