class User < ApplicationRecord
  before_create :assign_guid

  has_one :detail, class_name: 'UserDetail'

  validates :name, presence: true

  def assign_guid
    self.guid = SecureRandom.uuid if self.guid.blank?
  end
end
