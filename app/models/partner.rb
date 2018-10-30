class Partner < ApplicationRecord
  belongs_to :user
  has_many :subcontracts

  monetize :total_subcontract_amount_cents

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end

  def total_subcontract_amount_cents
    subcontracts.sum(:amount_cents)
  end
end
