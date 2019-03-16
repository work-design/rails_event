//= require rails_booking/repeat_type

$('#time_plan_time_list_id').dropdown({

  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location.origin);
    repeat_url.pathname = 'repeat_form';
    repeat_url.search = $.param({booking_type: this.dataset['bookingType'], repeat_type: value});

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }

});
