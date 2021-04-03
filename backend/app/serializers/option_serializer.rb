class OptionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :contracts
end
