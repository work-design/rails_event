class RailsBookingInit < ActiveRecord::Migration[5.0]

  def change

    create_table :locations do |t|
      t.references :area
      t.string :address
      t.timestamps
    end

    create_table :rooms do |t|
      t.references :area
      t.references :location
      t.string :room_number
      t.timestamps
    end

  end

end
