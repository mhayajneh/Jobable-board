# frozen_string_literal: true

class User < ApplicationRecord

  has_many :applications, foreign_key: :applicant

  has_secure_password

  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true
end
