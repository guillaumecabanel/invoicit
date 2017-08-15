class InvoicesController < ApplicationController
  before_action :bank_account_statement_exist
  before_action :set_company, only: [ :new, :create, :edit,
                                      :mark_as_paid, :send_via_email ]
  before_action :set_invoice, only: [:show, :edit, :update]

  def index
    @companies = policy_scope(Company)
    @invoices = policy_scope(Invoice)
    @invoices_sent = @invoices.where.not(sent_at: nil).order(sent_at: :desc)
    @invoices_to_send = @invoices.where(sent_at: nil).order(:created_at)
  end

  def show
    authorize @invoice
    @bank_account_statement = current_user.bank_account_statement
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:    "#{@invoice.company.title_to_snake_case}-#{@invoice.id_code}",
                layout: 'pdf',
                show_as_html: params.key?('debug'),
                # header: {
                #   html: {
                #     template: 'invoices/_header.pdf.slim'
                #   }
                # },
                footer: {
                  html: {
                    template: 'invoices/_footer.pdf.slim'
                  }
                }
      end
    end
  end

  def new
    @invoice = Invoice.new
    authorize @invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.company = @company
    authorize @invoice
    if @invoice.save
      redirect_to edit_company_invoice_path(@company, @invoice)
    else
      render :new
    end
  end

  def edit
    authorize @company
    authorize @invoice
    @task = Task.new(invoice: @invoice)
    authorize @task
  end

  def update
    authorize @invoice
    @invoice.update invoice_params
    if @invoice.valid?
      redirect_to company_path(@invoice.company)
    else
      render :edit
    end
  end

  def mark_as_paid
    @invoice = Invoice.find(params[:invoice_id])
    authorize @invoice
    @invoice.paid_at = Date.today
    if @invoice.save
      redirect_to company_path(@company)
    end
  end

  def send_via_email
    @invoice = Invoice.find(params[:invoice_id])
    authorize @invoice

    if @invoice.save
      InvoiceMailer.invoice_to_pay(@invoice).deliver_later
      @invoice.update(sent_at: Time.now)
      redirect_to company_path(@company)
    end
  end

  private

  def bank_account_statement_exist
    if current_user.bank_account_statement.nil?
      redirect_to new_bank_account_statement_path
    end
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :amount_with_vat, :title)
  end
end
