class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  has_many :companies, dependent: :destroy
  has_many :invoices, through: :companies
  has_one :bank_account_statement, dependent: :destroy

  validates :first_name,
            :last_name,
            :email,
            :phone_number,
            :company_name,
            :company_street,
            :company_postal_code,
            :company_city,
                          presence: true, on: :update
end
