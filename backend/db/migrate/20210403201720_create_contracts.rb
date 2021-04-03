class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts, if_not_exists: true do |t|
      t.integer :number
      t.string :status
      t.datetime :start_date
      t.datetime :end_date
      t.string :created_by

      t.timestamps
    end
  end
end
