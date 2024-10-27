class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :date, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
