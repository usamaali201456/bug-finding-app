# frozen_string_literal: true

class Bug < ApplicationRecord
  has_one_attached :image, dependent: :destroy

  belongs_to :user
  belongs_to :project

  enum bug_type: { feature: 0, bug: 1 }
  enum status: { created: 0, started: 1, completed: 2, resolved: 3 }

  validates :status, :bug_type, presence: true
  validates :title, presence: true, uniqueness: { scope: :project_id, message: 'same bug exists for this project.' }
  validate :image_type

  def bug_owner?(id)
    user_id == id
  end

  private

  def image_type
    return if image.content_type.in?(%('image/gif image/png'))

    errors.add(:image, 'needs to be a gif or png!')
  end
end
