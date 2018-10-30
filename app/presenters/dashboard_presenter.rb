include MoneyRails::ActionViewExtension

class DashboardPresenter
  attr_reader :years

  def initialize(params = {})
    @subcontracts = params[:subcontracts]
    @invoices = params[:invoices]
    @years = invoices_by_year.keys.sort.reverse
  end

  def values_for_monthly_turnover(year)
    monthly_turnover(year).values
  end

  def values_for_monthly_earnings(year)
    monthly_pairs = monthly_turnover(year).values.zip(monthly_subcontract_transferts(year).values)
    monthly_pairs.map do |turnover, subcontract_transfert|
      turnover - subcontract_transfert
    end
  end

  def yearly_customers_list(year)
    yearly_invoices_by_customer(year).keys.map do |client_name|
      client_name[0..5]
    end.to_json.html_safe
  end

  def values_yearly_customers_turnover(year)
    yearly_customers_turnover(year).values
  end

  def monthes
    [
      'jan','fév','mars','avr','mai','juin',
      'juil','août','sept','oct','nov','déc'
    ].to_json.html_safe
  end

  def invoices_for(year)
    invoices_by_year[year]
  end

  def subcontracts_for(year)
    subcontracts_by_year[year]
  end

  private


  def invoices_by_year
    @invoices.group_by{ |invoice| invoice.sent_at.year }.sort.to_h
  end

  def subcontracts_by_year
    @subcontracts.group_by{ |subcontract| subcontract.invoice.sent_at.year }.sort.to_h
  end

  def yearly_invoices_by_customer(year)
    invoices_by_year[year].group_by{|invoice| invoice.company.title}.sort.to_h
  end

  def yearly_customers_turnover(year)
    yearly_invoices_by_customer(year).transform_values do |customer_invoices|
      customer_invoices.sum(&:amount).to_f.fdiv(1000).round(2)
    end
  end

  def invoices_by_month(year)
    default_monthes_value = (1..12).map{ |month| [month, nil]}.to_h

    month_invoices = invoices_by_year[year].group_by{ |invoice| invoice.sent_at.month}

    default_monthes_value.merge(month_invoices)
  end

  def subcontracts_by_month(year)
    default_monthes_value = (1..12).map{ |month| [month, nil]}.to_h

    if subcontracts_by_year[year]
      month_subcontracts = subcontracts_by_year[year].group_by{ |subcontract| subcontract.invoice.sent_at.month}
    else
      month_subcontracts = {}
    end
    default_monthes_value.merge(month_subcontracts)
  end

  def monthly_turnover(year)
    invoices_by_month(year).transform_values do |invoices_of_the_month|
      if invoices_of_the_month.nil?
        0
      else
        invoices_of_the_month.sum(&:amount).to_f.fdiv(1000).round(2)
      end
    end
  end

  def monthly_subcontract_transferts(year)
    subcontracts_by_month(year).transform_values do |subcontracts_of_the_month|
      if subcontracts_of_the_month.nil?
        0
      else
        subcontracts_of_the_month.sum(&:amount).to_f.fdiv(1000).round(2)
      end
    end
  end
end
