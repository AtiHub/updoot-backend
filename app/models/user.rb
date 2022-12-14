class User < ApplicationRecord
  has_secure_password

  has_many :owned_communities, class_name: 'Community', foreign_key: 'creator_id',
    dependent: :nullify, inverse_of: :creator
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
