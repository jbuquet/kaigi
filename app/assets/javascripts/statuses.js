$(function() {
  $('.dropdown-menu').click(function(e) {
    e.stopPropagation();
  });

  if (RETRO.current_status_id) {
    $('#start_end_current_time').val('End');
    $('input[name="status[minutes]"]').prop('disabled', true).addClass('disabled').val(parseInt(CURRENT_STATUS.estimated_duration/60));
    $('input[name="status[seconds]"]').prop('disabled', true).addClass('disabled').val(CURRENT_STATUS.estimated_duration%60);
  } else if(Object.keys(CURRENT_STATUS).length) {
    $('#start_end_current_time').val('Start');
    $('input[name="status[minutes]"]').val(parseInt(CURRENT_STATUS.estimated_duration/60));
    $('input[name="status[seconds]"]').val(CURRENT_STATUS.estimated_duration%60);
  } else {
    $('#start_end_current_time').prop('disabled', true);
  }

  $('#set_time_next_phase').click(function(e) {
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val())*60 +
                              parseInt($('input[name="status[seconds]"]').val());

    status.retrospective_id = RETRO.id;

    CLIENT.publish('/statuses/set_time_next_phase', { status: status });
  });

  CLIENT.subscribe('/statuses/to_start_next_phase', function() {
    $('#start_end_current_time').prop('disabled', false);
  });

  $('#start_end_current_time').click(function(e){
    e.preventDefault();

    var currentStatus = $('#start_end_current_time').val();

    if (currentStatus == 'Start')
      CLIENT.publish('/statuses/start_current_phase', { retrospective_id: RETRO.id });
    else
      CLIENT.publish('/statuses/end_current_phase', { retrospective_id: RETRO.id });
  });

  CLIENT.subscribe('/statuses/started_current_phase', function() {

    $('#start_end_current_time').val('End');
    $('input[name="status[minutes]"]').prop('disabled', true).addClass('disabled');
    $('input[name="status[seconds]"]').prop('disabled', true).addClass('disabled');
  });

  CLIENT.subscribe('/statuses/ended_current_phase', function() {

    $('#start_end_current_time').val('Start');
    $('input[name="status[minutes]"]').prop('disabled', false).removeClass('disabled').val('00');
    $('input[name="status[seconds]"]').prop('disabled', false).removeClass('disabled').val('00');
  });
});