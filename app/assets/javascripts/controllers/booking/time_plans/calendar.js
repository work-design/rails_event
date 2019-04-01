var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  plugins: [ 'dayGrid' ],
  header: {
    left: 'prev,next',
    center: 'title',
    right: ''
  },
  showNonCurrentDates: false,
  fixedWeekCount: false,

  // height
  aspectRatio: 3,
  height: 'auto',
  firstDay: 1,

  // events
  eventSources: [
    {
      events: [],
    color: '#8fdf82',
  rendering: 'background'
}
]
});
calendar.render();
