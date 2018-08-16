//= require rails_com/fetch_xhr_script

$('[data-title="repeat_type"]').dropdown({

  onChange: function(value, text, $selectedItem){
    var repeat_url = new URL(window.location.origin);
    repeat_url.pathname = 'repeat_form';
    repeat_url.search = $.param({booking_type: this.dataset['bookingType'], repeat_type: value});

    fetch_xhr_script(repeat_url)
  }

});