$(function() {
  $('.dropdown-menu').click(function(e) {
    e.stopPropagation();
  });

  $('#start_end_current_time').prop('disabled', true).addClass('disabled');

  $('#set_time_next_phase').click(function(e) {
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val()) +
                              parseInt($('input[name="status[seconds]"]').val());

    status.retrospective_id = RETRO.id;

    CLIENT.publish('/statuses/set_time_next_phase', { status: status});
  });

  CLIENT.subscribe('/statuses/to_start_next_phase', function() {
    $('#start_end_current_time').prop('disabled', false);
  });

  $('#start_end_current_time').click(function(e){
    e.preventDefault();

    var currentStatus = $('#start_end_current_time').val();

    if (currentStatus == 'Start')
      CLIENT.publish('/statuses/start_current_phase', {});
    else
      CLIENT.publish('/statuses/end_current_phase', {});
  });

  CLIENT.subscribe('/statuses/started_current_phase', function() {

    $('#start_end_current_time').val('End');
    $('#set_timebox_section input').each(function() {
      $(this).prop('disabled', true).addClass('disabled');
    });
  });
});