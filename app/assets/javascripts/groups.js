function subscribeForRetroGroups() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/created', function(group) {
    var span = $('<span>').addClass('group label label-warning')
                          .html(group.id + ' ' + group.name)
                          .data({ group: group });

    var icon = $('<i>').addClass('glyphicon glyphicon-remove remove-group');
    span.append(icon);

    $('#groups').append(span);
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/deleted', function(group) {
    $('#groups .group').each(function() {
      var $this = $(this);
      if ($this.data('group').id == group.id) {
        $this.remove();
      }
    })
  });
}

$(function() {

  if (RETRO) {
    subscribeForRetroGroups();
  }

  $('form#new_group').submit(function(e) {
    e.preventDefault();

    var $this = $(this);
    var group = $this.serializeObject().group;
    group.retrospective_id = RETRO.id;

    CLIENT.publish('/groups/create', { group: group });

    $this.find('textarea').val('');
  });

  $('#groups').on('click', '.group .remove-group', function() {
    var $this = $(this);

    var group = $this.parents('.group').data('group');
    CLIENT.publish('/groups/delete', { id: group.id });
  });

});