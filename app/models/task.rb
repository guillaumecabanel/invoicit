class Task < ApplicationRecord
  belongs_to :invoice

  monetize :unit_price_cents, :price_without_vat_cents, :vat_cents, :price_with_vat_cents
  validates :title, :unit_price, :quantity, presence: true

  before_save :set_price_without_vat_cents, :set_vat_cents, :set_price_with_vat_cents

  def self.vat_rate
    0.2
  end

  private

  def set_price_without_vat_cents
    self.price_without_vat_cents = self.unit_price_cents * self.quantity
  end

  def set_vat_cents
    self.vat_cents = self.unit_price_cents * self.quantity * Task.vat_rate
  end

  def set_price_with_vat_cents
    self.price_with_vat_cents = self.price_without_vat_cents + self.vat_cents
  end
end
