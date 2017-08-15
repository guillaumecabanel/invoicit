class Invoice < ApplicationRecord
  belongs_to :company

  has_many :tasks, dependent: :destroy

  monetize :amount_cents, :amount_with_vat_cents
  before_save :set_amount_cents, :set_amount_with_vat_cents

  def paid?
    paid_at.present?
  end

  def sent?
    sent_at.present?
  end

  def date
    (sent_at || Date.today).strftime('%d.%m.%Y')
  end

  def id_code
    date = sent_at || Date.today
    index = company.invoices.where.not(sent_at: nil).order(:sent_at).index(self)
    index.nil? ? index = "xx" : index += 1
    "#{date.strftime('%Y%m%d')}-#{id}-#{index}"
  end

  def file_name
    "facture-#{company.title_to_snake_case}-#{id_code}"
  end

  private

  def set_amount_cents
    self.amount_cents = self.tasks.map{|t| t.price_without_vat_cents}.sum
  end

  def set_amount_with_vat_cents
    self.amount_with_vat_cents = self.tasks.map{|t| t.price_with_vat_cents}.sum
  end
end
