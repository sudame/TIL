class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}

  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: {maximum: 140}, presence: true
  validate :picture_size

  private

  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
