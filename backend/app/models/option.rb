class Option < ApplicationRecord
  has_many :options_contracts
  has_many :contracts, through: :option_contracts

  validates :name, presence: true
end
