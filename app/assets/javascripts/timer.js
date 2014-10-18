function timerExpired() {
 console.log('Activity time has expired')
}

function addMinutes(date, minutes) {
  return new Date(date.getTime() + minutes*60000);
}

function dateToUTC(date) {
  return new Date(date.toUTCString());
}

$(function() {
  console.log(moment().utc(RETRO.created_at));

  var liftoffTime = new Date(moment().utc(RETRO.created_at).format());
  $('#timer').countdown({ until: addMinutes(liftoffTime, 180), compact: true, description: '',
                          onExpiry: timerExpired });
});