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

    var votes_data = {};
    votes_data.max_votes = parseInt($('input[name="retrospective[max_votes]"]').val());

    if (votes_data.max_votes > 0) {
      votes_data.retrospective_id = RETRO.id;

      CLIENT.publish('/retrospectives/set_retro_votes', { votes_data: votes_data });
    }

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