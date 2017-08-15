class Company < ApplicationRecord
  belongs_to :user
  has_many :invoices

  monetize  :total_paid_with_vat_cents,
            :total_paid_without_vat_cents,
            :to_be_paid_with_vat_cents,
            :to_be_sent_with_vat_cents

  def title_to_snake_case
    title.downcase.split.join('_')
  end

  def total_paid_with_vat_cents
    invoices.where.not(paid_at: nil).sum(:amount_with_vat_cents)
  end

  def total_paid_without_vat_cents
    invoices.where.not(paid_at: nil).sum(:amount_cents)
  end

  def total_sent_with_vat_cents
    invoices.where.not(sent_at: nil).sum(:amount_with_vat_cents)
  end

  def to_be_paid_with_vat_cents
    invoices.where.not(sent_at: nil).where(paid_at: nil).sum(:amount_with_vat_cents)
  end

  def to_be_sent_with_vat_cents
    invoices.where(sent_at: nil).sum(:amount_with_vat_cents)
  end
end
