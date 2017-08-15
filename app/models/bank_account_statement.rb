class BankAccountStatement < ApplicationRecord
  belongs_to :user

  validates   :bank_code,
              :counter_number,
              :account_number,
              :key,
              :currency,
              :bank_address,
              :iban,
              :bic,
                    presence: true
end
