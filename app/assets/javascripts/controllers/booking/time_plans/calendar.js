var calendarEl = document.getElementById('calendar');

var calendar = new FullCalendar.Calendar(calendarEl, {
  schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source',
  plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'resourceDayGrid', 'resourceTimeGrid' ],
  defaultView: 'resourceTimeGridDay',
  header: {
    left: '',
    center: '',
    right: ''
  },
  selectable: true,
  minTime: '07:30:00',
  maxTime: '18:30:00',
  slotDuration: '00:10:00',
  resources: [
    { id: 'a', title: 'Auditorium A' },
    { id: 'b', title: 'Auditorium B' },
    { id: 'c', title: 'Auditorium C' }
  ]
});

calendar.render();
