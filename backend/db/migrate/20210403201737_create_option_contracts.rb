class CreateOptionContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :option_contracts do |t|

      t.timestamps
    end
  end
end
