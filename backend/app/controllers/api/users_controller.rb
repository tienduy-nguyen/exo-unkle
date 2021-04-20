class Api::UsersController < Api::BaseController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:me]
  before_action :check_admin, except: [:me] # user access only me query

  # show list user for admin
  # GET /users with pagination
  def index
    limit = params[:limit].to_i > 0 ? params[:limit].to_i : 25
    page = params[:p].to_i > 0 ? params[:p].to_i : 1
    contract_id = params[:contract_id]
    if contract_id
      @users = Contract.find(contract_id).clients
      @count = @users.length
      if @count > limit
        offset = (page - 1) * limit
        @users = offset > 0 ? @users.drop(offset) : @users
        @users = @users.first(limit)
      end
    else
      @users = User.offset((page - 1) * limit).limit(limit)
      @count = User.count
    end
    users_json = ActiveModel::SerializableResource.new(@users)
    return render json: { count: @count, users: users_json }
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # GET /auth/me
  def me
    if current_user
      user_json = ActiveModel::SerializableResource.new(@current_user)
      return render json: { user: user_json }
    end
    return render json: { user: nil }
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE users/:id
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :phone,
      :address,
      :is_admin
    )
  end

  def check_admin
    return true if current_user&.is_admin
    return render json: { error: "UnAuthorized", status: 401 }, status: 401
  end
end
