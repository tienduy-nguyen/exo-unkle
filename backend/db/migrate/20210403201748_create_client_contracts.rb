class CreateClientContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :client_contracts do |t|

      t.timestamps
    end
  end
end
