class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  before_create :set_default_value

  # Associations
  has_many :client_contracts, dependent: :destroy
  has_many :contracts, through: :client_contracts

  # Validations
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email adress please" }

  validates :password, length: { minimum: 3 }, presence: true, on: :create
  validates :password, length: { minimum: 3 }, presence: true, on: :update, if: :encrypted_password_changed?

  def full_name
    if self.first_name.nil? && self.last_name.nil?
      return self.email.split("@")[0]
    else
      return "#{self.first_name.capitalize unless self.first_name.nil?} #{self.last_name.capitalize unless self.last_name.nil?}"
    end
  end

  private

  def set_default_value
    self.is_admin = false if self.is_admin.nil? || self.is_admin.blank?
  end
end
