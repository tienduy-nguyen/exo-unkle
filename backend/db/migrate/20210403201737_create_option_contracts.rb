class CreateOptionContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :option_contracts do |t|
      t.belongs_to :option, index: true
      t.belongs_to :contract, index: true
      t.timestamps
    end
  end
end
