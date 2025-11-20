require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { build(:employee) }

  describe "validations" do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:salary) }
    it { should validate_numericality_of(:salary).is_greater_than(0) }

    it "is invalid with negative salary" do
      subject.salary = -100
      expect(subject.valid?).to be_falsey
    end

    it "is invalid with non-numeric salary" do
      subject.salary = "abc"
      expect(subject.valid?).to be_falsey
    end
  end
end
