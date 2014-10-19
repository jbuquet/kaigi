function subscribeForRetroGroups() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/created', function(group) {
    // For now we are assuming that a group is created with 2 stickies.
    var $droppable;
    var $dropped;
    $('#stickies .sticky').not('.group-color').each(function() {
      var $this = $(this);
      var sticky = $this.data('sticky');

      var initial_sticky_id = group.sticky_ids[0];
      var other_sticky_id = group.sticky_ids[1];
      if (sticky.id == initial_sticky_id) {
        $droppable = $this;
      } else if (sticky.id == other_sticky_id) {
        $dropped = $this;
      }
    });
    $droppable.data('group', group);

    drawGroupSticky($droppable, $dropped)
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/sticky_added', function(data) {
    var group = data.group;
    var sticky = data.sticky;

    var $droppable;
    var $dropped;
    $('#stickies .sticky').each(function() {
      if($(this).data('sticky') && $(this).data('sticky').id == sticky.id) {
        $dropped = $(this)
      }
      if($(this).data('group') && $(this).data('group').id == group.id) {
        $droppable = $(this)
      }
    });

    drawGroupSticky($droppable, $dropped)
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/sticky_removed', function(data) {
    var group = data.group;
    var sticky = data.sticky;

    $('#stickies .grouped').each(function() {
      var $this = $(this);

      if ($this.data('sticky').id == sticky.id) {
        drawUngroupSticky($this);
      }
    });
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/voted', function(data) {
    var group = data.group;
    var user = data.user;

    $('#stickies .group').each(function() {
      var $this = $(this);
      if ($this.data('group').id == group.id) {
        $this.find('.vote-count').html(group.votes);
      }
    });

    if (user.id == USER.id) {
      $('#user-remaining-votes').html(user.remaining_votes);

      if (user.remaining_votes == 0) {
        $('.vote-group').each(function() {
          $(this).remove();
        })
      }
    }
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/deleted', function(group) {
    $('.group').each(function() {
      var $this = $(this);
      if ($this.data('group').id == group.id) {
        $this.remove();
      }
    });
  });
}

var modalGroupNameCallBack;

function groupSticky($droppable, $dropped) {
  var droppedIntoGroup = $droppable.data('group');
  var droppedIntoSticky = $droppable.data('sticky');
  var droppedSticky = $dropped.data('sticky');

  if (droppedIntoGroup) {
    CLIENT.publish('/groups/add_sticky', { id: droppedIntoGroup.id, sticky_id: droppedSticky.id });

  } else if(!$droppable.hasClass('grouped')){

    $('#groupNameModal').modal('show');

    modalGroupNameCallBack = function() {
      var group_name = $('input[name="group[name]"]').val();

      if (!$.isEmptyObject(group_name)) {
        var group = {
          name: group_name,
          retrospective_id: RETRO.id,
          sticky_ids: [droppedIntoSticky.id, droppedSticky.id]
        };

        $('input[name="group[name]"]').val('');

        CLIENT.publish('/groups/create', { group: group });
      }
    }
  }
}

$(function() {
  if (RETRO) {
    subscribeForRetroGroups();
  }

  $('input[name="group[name]"]').focus();

  $('#groupNameModal').modal({show: false});

  $('#groupNameModal').on('shown.bs.modal', function () {
    $('input[name="group[name]"]').focus();
  });

  $('#groupNameModal').on('hidden.bs.modal', function () {
    modalGroupNameCallBack();
  });

  $('#group-name-form').on('submit', function (e) {
    e.preventDefault();

    modalGroupNameCallBack();
    $('#groupNameModal').modal('hide');
  });

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

  $('#stickies').on('click', '.group .vote-group', function(event) {
    var $this = $(this);

    var group = $this.parents('.group').data('group');

    CLIENT.publish('/groups/vote', { id: group.id, user_id: USER.id });
  });
});