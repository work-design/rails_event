//= require rails_booking/repeat_type

$('#time_plan_room_id').dropdown();

$('#time_plan_time_list_id').dropdown({
  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location.origin);
    repeat_url.pathname = 'time_items/select';
    repeat_url.search = $.param({time_list_id: value});

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }
});
$('#time_plan_time_item_id').dropdown();
