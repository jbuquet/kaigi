function userInitial(user) {
  return (user.name[0] || '').toUpperCase();
}

function subscribeForRetroUsers() {
  CLIENT.publish('/users/join', { user: USER });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/users/joined', function(user) {
    var span = $('<li>').addClass('user')
                        .css('background-color', user.color)
                        .html(userInitial(user))
                        .data({ user: user });

    var userExists = false;
    $('#users .user').each(function() {
      var $this = $(this);
      userExists = $this.data('user').id == user.id;
    });

    if (!userExists) {
      $('#users').removeClass('hide').append(span);
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