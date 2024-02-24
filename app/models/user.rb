class User < ApplicationRecord
  before_create :assign_guid

  has_one :detail, class_name: 'UserDetail'
  accepts_nested_attributes_for :detail

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  def assign_guid
    self.guid = SecureRandom.uuid if self.guid.blank?
  end
end
