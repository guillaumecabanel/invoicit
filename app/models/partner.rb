class Partner < ApplicationRecord
  belongs_to :user
  has_many :subcontracts

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
