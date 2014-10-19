function userInitial(user) {
  return (user.name[0] || '').toUpperCase();
}

function subscribeForRetroUsers() {
  CLIENT.publish('/users/join', { user: USER });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/users/joined', function(data) {
    var user = data.user;
    var usersCount = data.users_count - 1;

    var span = $('<li>').addClass('user')
                        .css('background-color', user.color)
                        .attr('title', user.name)
                        .html(userInitial(user))
                        .data({ user: user });

    var userExists = false;
    $('#users .user').each(function() {
      var $this = $(this);
      userExists = userExists || $this.data('user').id == user.id;
    });

    if (!userExists) {
      $('#users').removeClass('hide').append(span);
      $('#users-home').append(span);
      $('.dropdown-toggle').text('+' + usersCount);
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

  $('input[name="user[name]"]').focus();
});