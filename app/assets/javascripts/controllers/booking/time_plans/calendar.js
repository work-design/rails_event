var calendarEl = document.getElementById('calendar');

var calendar = new FullCalendar.Calendar(calendarEl, {
  schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source',
  plugins: [ 'dayGrid', 'timeGrid', 'resourceDayGrid', 'resourceTimeGrid' ],
  defaultView: 'resourceTimeGridDay',
  resources: [
    { id: 'a', title: 'Auditorium A' },
    { id: 'b', title: 'Auditorium B' },
    { id: 'c', title: 'Auditorium C' }
  ]
});

calendar.render();
