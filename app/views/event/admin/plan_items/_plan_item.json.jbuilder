json.extract! plan_item,
              :id,
              :planned_type,
              :planned_id,
              :plan_on,
              :place_id,
              :start_at,
              :finish_at,
              :qrcode_url
json.participants plan_item.all_members
