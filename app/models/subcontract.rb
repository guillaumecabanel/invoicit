class Subcontract < ApplicationRecord
  belongs_to :invoice
  belongs_to :partner

  monetize :amount_cents
end
