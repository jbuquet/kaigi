function timerExpired() {
  var status = {
    estimated_duration: 0,
    retrospective_id: RETRO.id
  };

  CLIENT.publish('/statuses/set_current_status', { status: status });
}

function addMinutes(date, minutes) {
  return new Date(date.getTime() + minutes*60000);
}

$(function() {
  if (!$.isEmptyObject(CURRENT_STATUS) && CURRENT_STATUS.status_type != 'invite_users'
        && CURRENT_STATUS.status_type != 'create_groups') {
    var liftoffTime = new Date(moment(CURRENT_STATUS.start_time).format());
    var estimatedMinutes = CURRENT_STATUS.estimated_duration / 60;

    $('#timer').countdown({ until: addMinutes(liftoffTime, estimatedMinutes), compact: true,
                            description: '', onExpiry: timerExpired });
  }

  if (!$.isEmptyObject(CURRENT_STATUS) && CURRENT_STATUS.status_type == 'finish') {
    $('#timer').text('--:--:--');
  }

});