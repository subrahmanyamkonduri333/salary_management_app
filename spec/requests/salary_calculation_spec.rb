require 'rails_helper'

RSpec.describe "Salary Calculation API", type: :request do
  let(:employee_india)  { Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 50000) }
  let(:employee_usa)    { Employee.create!(full_name: "B", job_title: "Dev", country: "United States", salary: 50000) }
  let(:employee_other)  { Employee.create!(full_name: "C", job_title: "Dev", country: "Germany", salary: 50000) }

  describe "GET /employees/:id/salary" do
    it "applies 10% deduction for India" do
      get "/employees/#{employee_india.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(10000)
      expect(body["net"]).to eq(90000)
    end

    it "applies 12% deduction for United States" do
      get "/employees/#{employee_usa.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(12000)
      expect(body["net"]).to eq(88000)
    end

    it "applies no deduction for other countries" do
      get "/employees/#{employee_other.id}/salary?gross=100000"
      body = JSON.parse(response.body)

      expect(body["tds"]).to eq(0)
      expect(body["net"]).to eq(100000)
    end
  end
end
