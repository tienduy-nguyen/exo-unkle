class CreateClientContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :client_contracts do |t|
      t.belongs_to :client, index: true
      t.belongs_to :contract, index: true
      t.timestamps
    end
  end
end
