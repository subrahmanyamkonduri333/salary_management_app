FactoryBot.define do
  factory :employee do
    full_name  { "John Doe" }
    job_title  { "Engineer" }
    country    { "India" }
    salary     { 50000 }
  end
end
