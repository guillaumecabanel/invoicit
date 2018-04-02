class InvoiceMailer < ApplicationMailer
  def invoice_to_pay(invoice)
    @invoice = invoice
    @bank_account_statement = @invoice.company.user.bank_account_statement
    @receiver_mail = @invoice.company.contact_email

    attachments["#{@invoice.file_name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: "#{@invoice.company.title_to_snake_case}-#{@invoice.id_code}",
        template: 'invoices/show.pdf.slim',
        layout: 'pdf'
      ),
      footer: {
        content: render_to_string(
          {
            template: 'invoices/_footer.pdf.slim',
            layout: 'pdf'
          }
        )
      }
    )

    mail(
      from:       "\"#{@invoice.company.user.first_name} #{@invoice.company.user.last_name}\" <#{ENV['APP_SENDER_EMAIL']}>",
      'reply-to': @invoice.company.user.email,
      cc:         @invoice.company.user.email,
      to:         @receiver_mail,
      subject:    @invoice.email_message.subject
    )
  end
end
