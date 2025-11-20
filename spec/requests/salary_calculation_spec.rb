require 'rails_helper'

RSpec.describe "Salary Calculation API", type: :request do
  let(:employee_india)  { create(:employee, country: "India") }
  let(:employee_usa)    { create(:employee, country: "United States") }
  let(:employee_other)  { create(:employee, country: "Brazil") }

  describe "GET /employees/:id/salary" do
    it "calculates deductions for India" do
      get "/employees/#{employee_india.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(10000)
      expect(body["net"]).to eq(90000)
    end

    it "calculates deductions for US" do
      get "/employees/#{employee_usa.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(12000)
      expect(body["net"]).to eq(88000)
    end

    it "calculates no deductions for other countries" do
      get "/employees/#{employee_other.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(0)
      expect(body["net"]).to eq(100000)
    end

    it "returns error for missing gross salary" do
      get "/employees/#{employee_india.id}/salary"

      expect(response).to have_http_status(:bad_request)
    end

    it "returns 404 for invalid employee" do
      get "/employees/999999/salary?gross=100000"
      expect(response).to have_http_status(:not_found)
    end
  end
end
