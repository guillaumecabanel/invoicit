module EmailMessagesHelper

  def next_id_code invoice
    date = invoice.sent_at || Time.now
    index = invoice.company.invoices.where.not(sent_at: nil).order(:sent_at).count
    index += 1
    "#{date.strftime('%Y%m%d')}-#{invoice.company.id}-#{index}"
  end
end
