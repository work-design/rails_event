json.extract! time_booking,
              :id,
              :time_list_id,
              :time_item_id,
              :place_id,
              :booking_on,
              :start_at,
              :finish_at,
              :booker_type,
              :booker_id,
              :created_at
json.booked time_booking.booked, :id, :title
