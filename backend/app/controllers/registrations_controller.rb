class RegistrationsController < Devise::RegistrationsController

  # Sign up
  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    render json: resource
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password
    )
  end
end
