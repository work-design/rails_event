module FullCalendarHelper
  extend self

  def repeat_settings(options = {})
    settings = {
      defaultDate: Date.today.to_s,
      dayCount: 7,
      columnHeaderFormat: {
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        weekday: 'short'
      }
    }
    if options[:repeat_type] == 'monthly'
      settings.merge!(
        defaultDate: Date.today.beginning_of_month.to_s,
        dayCount: 30,
        columnHeaderFormat: { day: 'numeric' }
      )
    elsif options[:repeat_type] == 'weekly'
      settings.merge!(
        defaultDate: Date.today.beginning_of_week.to_s,
        dayCount: 7,
        columnHeaderFormat: { weekday: 'short' }
      )
    end
    settings
  end


end
