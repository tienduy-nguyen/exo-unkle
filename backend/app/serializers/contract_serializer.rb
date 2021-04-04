class ContractSerializer < ActiveModel::Serializer
  attributes :id, :number, :status, :created_by, :start_date, :end_date

  # has_many :clients
  # has_many :options
end
