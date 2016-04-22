class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :repeat_day
      t.integer :repeat_each_days
      t.integer :repeat_each_months

      t.timestamps null: false
    end
  end
end
