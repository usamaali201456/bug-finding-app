# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # include ApplicationConstants::User

  enum user_type: { manager: 0, dev: 1, qa: 2 }

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :bugs, dependent: :destroy
  has_many :owned_projects, inverse_of: :creator, foreign_key: :creator_id, dependent: :destroy, class_name: 'Project'

  validates :name, :user_type, presence: true
  validates :name, length: { minimum: 2 }

  scope :developers, -> { where(user_type: 'dev') }
  scope :testers, -> { where(user_type: 'qa') }
end
