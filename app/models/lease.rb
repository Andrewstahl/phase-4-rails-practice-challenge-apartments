class Lease < ApplicationRecord
  belongs_to :apartment
  belongs_to :tenant

  validates :rent, numericality: { only_integer: true }
  validates :apartment_id, presence: true
  validates :tenant_id, presence: true
end
