json.extract! time_booking,
              :id,
              :time_list_id,
              :time_item_id,
              :room_id,
              :booking_on,
              :created_at,
              :updated_at
json.time_item time_booking.time_item, :id, :start_at, :finish_at
