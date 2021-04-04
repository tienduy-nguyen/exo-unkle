class Api::ContractsController < ApplicationController
  before_action :set_formation, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_admin, only: [:create, :update]

  # with pagination
  def index
    limit = params[:limit].to_i > 0 ? params[:limit].to_i : 25
    page = params[:p].to_i > 0 ? params[:p].to_i : 1
    user_id = params[:client_id] || params[:user_id]
    option_id = params[:option_id]

    if user_id
      sql = "select c.* from contracts c, client_contracts cl where c.id = cl.contract_id and cl.client_id = #{user_id}"
      @formations = ActiveRecord::Base.connection.execute(sql)
      @count = @formations.count
      if @count > limit
        offset = (page - 1) * limit
        sql = "select c.* from contracts c, client_contracts cl where c.id = cl.contract_id and cl.client_id = #{user_id} offset(#{offset}) limit(#{limit})"
        @formations = ActiveRecord::Base.connection.execute(sql)
      end
      return render json: { count: @count, formation: @formations }
    end

    if option_id
      sql = "select c.* from contracts c, option_contracts op where c.id = op.contract_id and op.option_id = #{option_id}"
      @formations = ActiveRecord::Base.connection.execute(sql)
      @count = @formations.count
      if @count > limit
        offset = (page - 1) * limit
        sql = "select c.* from contracts c, option_contracts op where c.id = op.contract_id and op.option_id = #{option_id} offset(#{offset}) limit(#{limit})"
        @formations = ActiveRecord::Base.connection.execute(sql)
      end
      return render json: { count: @count, formation: @formations }
    end

    @formations = Contract.offset((page - 1) * limit).limit(limit)
    @count = Contract.count
    # formation_json = ActiveModel::SerializableResource.new(@formations)
    render json: { count: @count, formation: @formations }
  end

  def show
    render json: @constract
  end

  def create
    @contract = Contract.new
    @contract.created_by = contract_params[:created_by]
    @contract.start_date = contract_params[:start_date]

    # try-catch error
    begin
      ActiveRecord::Base.transaction do
        if @contract.save
          options = contract_params[:options]

          # check if options empty
          if options.nil? || options.blank? || options.length <= 0
            raise ActiveRecord::Rollback
            return render json: { error: "Options is required", status: 500 }, status: :unprocessable_entity
          end

          # create option_contract
          options.each do |option_id|
            # ensure option_id given is exact
            id = Option.find(option_id).id
            OptionContract.create(contract_id: @contract.id, option_id: id)
          end

          # create client_contract
          client_id = User.find(contract_params[:client_id]).id
          ClientContract.create(client_id: client_id, contract_id: @contract.id)

          return render json: @contract
        else
          return render json: @contract.errors, status: :unprocessable_entity
        end
      end
    rescue => exception
      render json: { error: exception, status: 500 }, status: :unprocessable_entity
    end
  end

  # PUT /contracts/:id
  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.is_admin
      @contract.destroy
      return render json: { destroy: true }, status: 200
    end
    # User is not admin
    client_contract = ClientContract.find_by(client_id: current_user.id, contract_id: @contract_id)
    if client_contract
      client_contract.destroy
      return render json: { destroy: true }, status: 200
    end
    render json: { error: "UnAuthorized", status: 401 }, status: 401
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract)
      .permit(:status,
              :start_date, :end_date, :created_by,
              :client_id, :options)
    #:options is array of option_id, ex: [1,5,3,6]

    # create contract with params: :start_date, :created_by, :client_id, :options
  end

  def check_admin
    return true if current_user&.is_admin
    render json: { error: "UnAuthorized", status: 401 }, status: 401
  end
end
