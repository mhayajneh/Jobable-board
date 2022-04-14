# frozen_string_literal: true

class Job < ApplicationRecord

  scope :filter_by_title, ->(title) { where('title like ?', "%#{title}%") }
  scope :filter_by_creation_date, ->(created_at) { where('created_at like ?', "%#{created_at}%") }

  has_many :applications, dependent: :destroy

  # using heroku and elasicsearch commented for heroku

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  # settings do
  #   mappings dynamic: false do
  #     indexes :description, type: :text
  #   end
  # end


  validates_presence_of :title, :description
end
