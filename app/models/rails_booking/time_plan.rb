class TimePlan < ApplicationRecord
  include RailsBookingRecurrence

  attribute :room_id, :integer
  attribute :begin_on, :date, default: -> { Date.today }
  attribute :end_on, :date
  attribute :time_item_ids, :integer, array: true, default: []

  belongs_to :room, optional: true
  belongs_to :plan, polymorphic: true
  belongs_to :time_item, optional: true
  belongs_to :time_list, optional: true


  validate :validate_end_on

  def validate_end_on
    return if end_on.nil?
    r1 = same_begin_items.exists?
    r2 = same_end_items.exists?
    r3 = same_scopes.where(end_on: nil).exists?
    if r1 || r2 || r3
      self.errors.add :end_on, 'date range is not valid'
    end
    unless end_on > begin_on
      self.errors.add :end_on, 'Finish At Should large then Start at time!'
    end
  end

  def same_scopes
    self.class.default_where(
      {
        plan_type: self.plan_type,
        plan_id: self.plan_id,
        room_id: self.room_id
      },
      { room_id: { allow: nil } }
    )
  end

  def same_begin_items
    self.same_scopes.default_where(
      'begin_on-lte': self.begin_on,
      'end_on-gte': self.begin_on
    )
  end

  def same_end_items
    self.same_scopes.default_where(
      'begin_on-lte': self.end_on,
      'end_on-gte': self.end_on
    )
  end

  def start_at

  end

  def finish_at

  end

end
