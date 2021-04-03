class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options, if_not_exists: true do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
