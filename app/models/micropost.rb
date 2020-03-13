# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :activity
  # belongs_to :user
  # default_scope -> { order(created_at: :desc) }
  validates :activity_id, presence: true
end
