require 'rails_helper'

describe Applicant do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :phone }
  it { should validate_uniqueness_of :phone }
  it { should validate_presence_of :region }
end