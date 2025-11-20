require 'rails_helper'

RSpec.describe "Salary Metrics API", type: :request do
  before do
    create(:employee, country: "India", job_title: "Engineer", salary: 50000)
    create(:employee, country: "India", job_title: "Engineer", salary: 70000)
    create(:employee, country: "India", job_title: "Designer", salary: 60000)
  end

  describe "GET /metrics/salary/country" do
    it "returns salary statistics" do
      get "/metrics/salary/country?country=India"
      body = JSON.parse(response.body)

      expect(body["min"]).to eq(50000)
      expect(body["max"]).to eq(70000)
      expect(body["avg"]).to eq(60000.0)
    end

    it "returns null values if no employees in country" do
      get "/metrics/salary/country?country=Japan"
      body = JSON.parse(response.body)

      expect(body["min"]).to be_nil
      expect(body["max"]).to be_nil
      expect(body["avg"]).to be_nil
    end

    it "returns error if country not provided" do
      get "/metrics/salary/country"
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET /metrics/salary/job_title" do
    it "returns average salary for job title" do
      get "/metrics/salary/job_title?job_title=Engineer"
      body = JSON.parse(response.body)

      expect(body["avg"]).to eq(60000.0)
    end

    it "returns nil if no employees with job title" do
      get "/metrics/salary/job_title?job_title=Pilot"
      body = JSON.parse(response.body)

      expect(body["avg"]).to be_nil
    end

    it "returns error if job_title not provided" do
      get "/metrics/salary/job_title"
      expect(response).to have_http_status(:bad_request)
    end
  end
end
