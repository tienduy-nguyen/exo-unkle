require "securerandom"

class Contract < ApplicationRecord
  # enum status: [:pending, :active, :finished]
  has_many :client_contracts, dependent: :destroy
  has_many :clients, class_name: "User", through: :client_contracts, foreign_key: :client_id
  has_many :option_contracts, dependent: :destroy
  has_many :options, through: :option_contracts

  # call back
  before_create :set_default_value
  before_save :end_date_when_status_finished, if: :status_changed?
  before_create :create_auto_number

  # Validation
  # validates :number, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :created_by, presence: true

  validate :end_date_is_after_start_date, if: :end_date_changed?

  def self.update_status_contract
    sql = "update users set status = 
              case when status = 'pending' and start_date < now() then 'active'
              case when status <> 'finished' and end_date < now() then 'finished'
              else status end;
          "
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def end_date_is_after_start_date
    return if self.end_date.blank? || self.start_date.blank?
    if self.end_date < self.start_date
      errors.add(:end_date, "End date must be after start date of contract.")
    end
  end

  def create_auto_number
    if self.number.blank?
      random_num = SecureRandom.random_number(100000000)
      is_exists = Contract.find_by(number: random_num)
      while is_exists
        random_num = SecureRandom.random_number(100000000)
        is_exists = Contract.find_by(number: random_num)
      end
      self.number = random_num
    end
  end

  def set_default_value
    self.status = "pending"

    if self.start_date.to_date <= Time.now.to_date
      self.start_date = Time.now
      self.status = "active"
    end
  end

  def end_date_when_status_finished
    return if self.status != "finished"
    if self.end_date.blank?
      errors.add(:end_date, "End date must be set when cancel contract")
    end
  end
end
