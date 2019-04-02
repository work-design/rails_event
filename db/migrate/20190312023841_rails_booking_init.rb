class RailsBookingInit < ActiveRecord::Migration[5.0]

  def change

    create_table :time_lists do |t|
      t.string :name
      t.string :code
      t.integer :interval_minutes, default: 0
      t.integer :item_minutes, default: 45
      t.boolean :default
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
      t.date :begin_on
      t.date :end_on
      t.string :repeat_type
      t.integer :repeat_days, array: true
      t.timestamps
    end

    create_table :time_bookings do |t|
      t.references :room
      t.references :booking, polymorphic: true
      t.references :time_item
      t.references :time_list
      t.date :booking_on
      t.timestamps
    end

  end

end
