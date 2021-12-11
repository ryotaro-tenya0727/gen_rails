class Task < ApplicationRecord
  validates :name, presence: true
  validate :validate_name_not_including_comma
  belongs_to :user
  scope :recent, -> {order(created_at: :desc)}

  private
  def validate_name_not_including_comma
    errors.add(:name,'にカンマを含めることはできないよ〜ん') if name&.include?(',')
  end
end
