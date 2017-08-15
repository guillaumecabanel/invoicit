module CompaniesHelper

  def pretty_k_money(amount_money)
    if amount_money.to_i > 1000 || amount_money.to_i < -1000
      "#{humanized_money amount_money /1000} k€"
    elsif amount_money.to_i == 0
      '-'
    else
      "#{humanized_money amount_money} €"
    end
  end

  def total_paid_without_vat(companies)
    companies.map{|company| company.total_paid_without_vat}.sum
  end

  def total_paid_with_vat(companies)
    companies.map{|company| company.total_paid_with_vat}.sum
  end

  def to_be_paid_with_vat(companies)
    companies.map{|company| company.to_be_paid_with_vat}.sum
  end

  def to_be_sent_with_vat(companies)
    companies.map{|company| company.to_be_sent_with_vat}.sum
  end

  def pretty_phone_number(number)
    number.gsub(/.{2}/) {|n| n + ' '}.strip
  end

end
