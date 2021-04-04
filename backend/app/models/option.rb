class Option < ApplicationRecord
  has_many :option_contracts
  has_many :contracts, through: :option_contracts

  validates :name, presence: true
end
