require 'rails_helper'

RSpec.describe Application, type: :model do
  it { should belong_to(:job) }
  it { should validate_presence_of(:applicant) }
end
