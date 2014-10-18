$(function() {
  $('#start_current_time').prop('disabled', true);
  $('#end_current_time').prop('disabled', true);

  $('#set_time_next_phase').click(function(e) {
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val()) +
                              parseInt($('input[name="status[seconds]"]').val());

    status.retrospective_id = RETRO.id;

    CLIENT.publish('/statuses/set_time_next_phase', { status: status});
  });

  CLIENT.subscribe('/statuses/to_start_next_phase', function() {
    // TODO: close modal

    $('#start_current_time').prop('disabled', false);
  });
});