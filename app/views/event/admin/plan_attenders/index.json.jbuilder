json.plan_item @plan_item, partial: 'booking/plan_items/plan_item', as: :plan_item
json.event @plan_item.event, :id, :title
json.event_participants @event_participants, partial: 'event_participant', as: :event_participant
if @plan_item&.event_item
  json.event_item @plan_item.event_item, :id, :title
end
