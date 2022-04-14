# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
