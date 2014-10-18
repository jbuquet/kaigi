function subscribeForRetroUsers() {
  CLIENT.publish('/users/join', { user: USER });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/users/joined', function(user) {
    var span = $('<span>').addClass('user label label-success')
                          .html(user.id + ' ' + user.name[0])
                          .data({ user: user });

    var userExists = false;
    $('#users .user').each(function() {
      var $this = $(this);
      userExists = $this.data('user').id == user.id;
    });

    if (!userExists) {
      $('#users').append(span);
    }
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/stickies/left', function(user) {
    console.log('User left', user)
  });
}

$(function() {
  if (USER) {
    subscribeForRetroUsers();
  }
});