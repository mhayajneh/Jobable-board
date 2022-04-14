class Application < ApplicationRecord
  belongs_to :job


  validates_presence_of :applicant
end
