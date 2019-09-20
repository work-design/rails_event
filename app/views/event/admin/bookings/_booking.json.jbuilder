json.extract! booking,
              :id,
              :time_item_id,
              :plan_item_id,
              :place_id,
              :booking_on,
              :start_at,
              :finish_at,
              :booker_type,
              :booker_id,
              :created_at
json.booked booking.booked, :id, :name
