$(function() {
  $('#start_current_time').click(function(e){
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val()) * 60;

    status.retrospective_id = RETRO.id;

    CLIENT.publish('/statuses/start_current_phase', { status: status });
  });

  $('#end_current_time').click(function(e){
    e.preventDefault();

    var status = {
      estimated_duration: 0,
      retrospective_id: RETRO.id
    };

    CLIENT.publish('/statuses/end_current_phase', { status: status });
  });

  CLIENT.subscribe('/statuses/started_current_phase', function() {
    location.reload();
  });

  CLIENT.subscribe('/statuses/ended_current_phase', function() {
    location.reload();
  });
});