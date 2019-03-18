class RailsBookingInit < ActiveRecord::Migration[5.0]

  def change

    create_table :time_lists do |t|
      t.string :name
      t.string :code
      t.timestamps
    end

    create_table :time_items do |t|
      t.references :time_list
      t.time :start_at
      t.time :finish_at
      t.integer :position, default: 1
      t.timestamps
    end

    create_table :time_plans do |t|
      t.references :room
      t.references :time_list
      t.references :time_item
      t.references :plan, polymorphic: true
      t.string :repeat_type
      t.integer :repeat_days, array: true
      t.timestamps
    end

  end

end
