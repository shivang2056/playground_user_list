class User < ApplicationRecord
  before_create :assign_guid

  has_one :detail, class_name: 'UserDetail'
  accepts_nested_attributes_for :detail

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
  scope :search_by_name, -> (name) { where("name like ?", "%#{name}%") if name.present? }

  def assign_guid
    self.guid = SecureRandom.uuid if self.guid.blank?
  end
end
