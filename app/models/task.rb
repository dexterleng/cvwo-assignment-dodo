class Task < ApplicationRecord
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags, allow_destroy: true
  validates :title, presence: true, allow_blank: false, length: { maximum: 140 }
  belongs_to :user
  validates :user_id, presence: true
end
