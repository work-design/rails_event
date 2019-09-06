json.plan_item @plan_item, partial: 'booking/plan_items/plan_item', as: :plan_item
json.event @plan_item.event, :id, :title
json.event_members @event_members, partial: 'event_member', as: :event_member
if @plan_item&.event_item
  json.event_item @plan_item.event_item, :id, :title
end
