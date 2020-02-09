# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :user
  has_many :microposts, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true
  validates :category, presence: true
  validate  :picture_size

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end
end
