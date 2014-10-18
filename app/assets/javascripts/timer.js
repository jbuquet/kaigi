function timerExpired() {
  CLIENT.publish('/statuses/end_current_phase', { retrospective_id: RETRO.id });
}

function addMinutes(date, minutes) {
  return new Date(date.getTime() + minutes*60000);
}

$(function() {
  if (!$.isEmptyObject(CURRENT_STATUS)) {
    var liftoffTime = new Date(moment(CURRENT_STATUS.start_time).format());
    var estimatedMinutes = CURRENT_STATUS.estimated_duration / 60;

    $('#timer').countdown({ until: addMinutes(liftoffTime, estimatedMinutes), compact: true,
                            description: '', onExpiry: timerExpired });
  }

});