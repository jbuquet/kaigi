function subscribeForRetroStatuses() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/statuses/after_set_current_status', function() {
    location.reload();
  });
}

$(function() {
  if (RETRO) {
    subscribeForRetroStatuses();
  }

  $('input[name="status[minutes]"]').numeric({ negative: false, decimal: false });

  $('#start_current_time').click(function(e){
    e.preventDefault();

    var status = {};

    status.estimated_duration = parseInt($('input[name="status[minutes]"]').val()) * 60;

    if (status.estimated_duration > 0) {
      status.retrospective_id = RETRO.id;

      CLIENT.publish('/statuses/set_current_status', { status: status });
    }
  });

  $('#end_current_time').click(function(e){
    e.preventDefault();

    var status = {
      estimated_duration: 0,
      retrospective_id: RETRO.id
    };

    CLIENT.publish('/statuses/set_current_status', { status: status });
  });
});