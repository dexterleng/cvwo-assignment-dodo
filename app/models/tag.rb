class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  before_save :downcase_fields

  def existing_tag
    Tag.find_by(name: name.downcase)
  end

  def downcase_fields
    self.name.downcase!
  end

  def save_if_not_exists
    tag = existing_tag
    if tag.blank?
      save
      return self
    end
    tag
  end
end
