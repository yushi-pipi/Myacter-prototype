# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category, presence: true
  validates :title, presence: true
end
