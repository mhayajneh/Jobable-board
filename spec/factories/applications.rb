# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    applicant { Faker::Movies::StarWars.character }
    seen false
    job_id nil
  end
end
