//= require rails_booking/calendar

$('#time_plan_room_id').dropdown();

$('#time_plan_time_list_id').dropdown({
  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location.origin);
    repeat_url.pathname = 'time_items/add_event';
    repeat_url.searchParams.set('time_list_id', value);
    repeat_url.searchParams.set('repeat_type', document.getElementById('time_plan_repeat_type').value);

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }
});
$('#time_plan_time_item_id').dropdown();
remote_js_load([window.location.href]);
