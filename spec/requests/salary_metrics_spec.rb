require 'rails_helper'

RSpec.describe "Salary Metrics API", type: :request do
  before do
    Employee.create!(full_name: "A", job_title: "Engineer", country: "India", salary: 50000)
    Employee.create!(full_name: "B", job_title: "Engineer", country: "India", salary: 70000)
    Employee.create!(full_name: "C", job_title: "Designer", country: "India", salary: 60000)
  end

  describe "GET /metrics/salary/country" do
    it "returns min, max, average for a given country" do
      get "/metrics/salary/country?country=India"

      body = JSON.parse(response.body)
      expect(body["min"]).to eq(50000)
      expect(body["max"]).to eq(70000)
      expect(body["avg"]).to eq(60000)
    end
  end

  describe "GET /metrics/salary/job_title" do
    it "returns average salary for a job title" do
      get "/metrics/salary/job_title?job_title=Engineer"

      body = JSON.parse(response.body)
      expect(body["avg"]).to eq(60000)
    end
  end
end
