class TasksController < ApplicationController
  before_action :set_invoice, only: [:create, :destroy]

  def create
    @task = Task.new task_params
    @task.invoice = @invoice
    authorize @task
    if @task.save
      redirect_to edit_company_invoice_path(@invoice.company, @invoice)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task
    @task.destroy
    redirect_to edit_company_invoice_path(@invoice.company, @invoice)
  end

  private

  def set_invoice
    @invoice = Invoice.find params[:invoice_id]
  end

  def task_params
    params.require(:task).permit(:title, :quantity, :unit_price, :vat)
  end
end
