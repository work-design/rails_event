$('[data-title="repeat_type"]').dropdown({
  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location.origin);
    repeat_url.pathname = 'calendar';
    repeat_url.search = $.param({booking_type: this.dataset['bookingType'], repeat_type: value});

    Rails.ajax({url: repeat_url, type: 'GET', dataType: 'script'});
  }
});
