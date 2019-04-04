var calendarEl = document.getElementById('calendar');
var DateTime = luxon.DateTime;
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
  events: [],
  eventClick: function(info) {
    alert('Event: ' + info.event.title);
    alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
    alert('View: ' + info.view.type);

    // change the border color just for fun
    info.el.style.borderColor = 'red';
  }
});

calendar.render();
