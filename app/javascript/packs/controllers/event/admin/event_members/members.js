import 'stimulus_com/checkbox'

$('#q_office_id').dropdown();

$('input[name=member_id]').change(function(){
  var remind_link = new URL($('#checked_people')[0].href);
  $('#checked_people').attr('href', remind_link.pathname + '?add_ids=' + getAddIds('member_id') + '&remove_ids=' + getRemoveIds('member_id'));
});

$('input[name=member_all]').change(function(){
  var remind_link = new URL($('#checked_people')[0].href);
  $('#checked_people').attr('href', remind_link.pathname + '?add_ids=' + getAddIds('member_id') + '&remove_ids=' + getRemoveIds('member_id'));
});


