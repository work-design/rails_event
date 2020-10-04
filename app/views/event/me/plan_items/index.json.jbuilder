json.plan_items @plan_items do |date, items|
  json.partial! 'plan_items', locals: { date: date, items: items }
end
