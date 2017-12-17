class EstimatesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:invoice_id])
    authorize @invoice

    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:    "#{@invoice.company.title_to_snake_case}-#{@invoice.id_code_for_estimate}",
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
end
