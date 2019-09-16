json.plan_items @plan_items do |date, items|
  json.partial! 'plan_item', locals: { date: date, items: items }
end
