var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source',
  plugins: [ 'dayGrid', 'timeGrid', 'resourceDayGrid', 'resourceTimeGrid' ],
  header: {
    left: '',
    center: '',
    right: ''
  },
  defaultView: 'timeGrid',
  defaultDate: '2001-01-01',
  columnHeaderFormat: {
    weekday: 'short'
  },
  dayCount: 7,
  allDaySlot: false,
  minTime: '07:30:00',
  maxTime: '18:30:00',
  slotDuration: '00:10',
  slotLabelInterval: '1:00',
  slotLabelFormat: {
    hour: 'numeric',
    minute: '2-digit',
    omitZeroMinute: true,
    hour12: false
  },
  eventClick: function(info) {
    var url = new URL(window.location);
    var data = new FormData(document.getElementById('time_plan_form'));
    data.set('time_item_id', info.event.id);
    data.set('time_item_start', info.event.start.toISOString());

    Rails.ajax({url: url, type: 'POST', data: data, dataType: 'script'});
  }
});

calendar.render();
