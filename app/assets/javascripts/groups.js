function subscribeForRetroGroups() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/created', function(group) {
    // For now we are assuming that a group is created with 2 stickies.
    var $droppable;
    var $dropped;
    $('#stickies .sticky').each(function() {
      var $this = $(this);

      if ($this.data('sticky').id == group.initial_sticky_id) {
        $droppable = $this;
      } else if ($.inArray($this.data('sticky').id, group.sticky_ids)) {
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
      var $this = $(this);

      if ($this.data('sticky').id == group.initial_sticky_id) {
        $droppable = $this;
      } else if ($this.data('sticky').id == sticky.id) {
        $dropped = $this;
      }
    });

    drawGroupSticky($droppable, $dropped)
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/groups/deleted', function(group) {
    $('#groups .group').each(function() {
      var $this = $(this);
      if ($this.data('group').id == group.id) {
        $this.remove();
      }
    });
  });
}

function groupSticky($droppable, $dropped) {
  var droppedIntoGroup = $droppable.data('group');
  var droppedIntoSticky = $droppable.data('sticky');
  var droppedSticky = $dropped.data('sticky');

  if (droppedIntoGroup) {
    CLIENT.publish('/groups/add_sticky', { id: droppedIntoGroup.id, sticky_id: droppedSticky.id });
  } else {
    var group = {
      retrospective_id: RETRO.id,
      initial_sticky_id: droppedIntoSticky.id,
      sticky_ids: [droppedIntoSticky.id, droppedSticky.id]
    };

    CLIENT.publish('/groups/create', { group: group });
  }
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