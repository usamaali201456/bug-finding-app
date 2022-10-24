# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy

  belongs_to :creator, inverse_of: :owned_projects, class_name: 'User'

  validates :title, presence: true

  def project_owner?(id)
    creator_id == id
  end

  # def manager
  #   users.find_by(user_type: 'manager')
  # end
end
