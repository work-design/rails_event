module FullCalendarHelper
  extend self

  def repeat_settings(repeat_type: 'once')
    settings = {
      defaultDate: default_date(repeat_type: repeat_type).to_s
    }

    case repeat_type
    when 'once'
      settings.merge!(
        dayCount: 7,
        columnHeaderFormat: {
          year: 'numeric',
          month: 'numeric',
          day: 'numeric',
          weekday: 'short'
        }
      )
    when 'monthly'
      settings.merge!(
        dayCount: 31,
        columnHeaderFormat: { day: 'numeric' }
      )
    when 'weekly'
      settings.merge!(
        dayCount: 7,
        columnHeaderFormat: { weekday: 'short' }
      )
    end
    settings
  end


end
