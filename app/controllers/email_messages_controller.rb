class EmailMessagesController < ApplicationController
  before_action :set_invoice, only: [:edit, :update]

  def edit
  end

  def update
    if @invoice.email_message.update(email_message_params)
      if @invoice.update(sent_at: Time.now)
        InvoiceMailer.invoice_to_pay(@invoice).deliver_later
        redirect_to company_path(@invoice.company)
      else
        render :edit
      end
    else
      render :edit
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id])
    authorize @invoice
  end

  def email_message_params
    params.require(:email_message).permit(:subject, :content)
  end
end
