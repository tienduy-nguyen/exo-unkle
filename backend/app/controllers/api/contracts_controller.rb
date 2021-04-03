class Api::ContractsController < ApplicationController
  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:start_date, :created_by)
  end
end
