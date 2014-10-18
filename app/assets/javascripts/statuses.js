$(function() {
  $('#start_current_time').click(function(e){
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val()) * 60 +
                                  parseInt($('input[name="status[seconds]"]').val());

    status.retrospective_id = RETRO.id;

    CLIENT.publish('/statuses/start_current_phase', { status: status });
  });

  $('#end_current_time').click(function(e){
    e.preventDefault();

    CLIENT.publish('/statuses/end_current_phase', { retrospective_id: RETRO.id });
  });

  CLIENT.subscribe('/statuses/started_current_phase', function() {
    location.reload();
  });

  CLIENT.subscribe('/statuses/ended_current_phase', function() {
    location.reload();
  });
});