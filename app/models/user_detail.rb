class UserDetail < ApplicationRecord
  belongs_to :user

  validates :email, presence: true

  enum :title, { 'Dr.' => 0, 'Mr.' => 1, 'Mrs.' => 2, 'Ms.' => 3, 'Prof.' => 4 }
end
