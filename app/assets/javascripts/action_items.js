function subscribeForRetroActionItems() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/action_items/created', function(actionItem) {
    var panel = $('<div>').addClass('panel panel-success text-center action-item');
    panel.data('actionItem', actionItem);

    var panelBody = $('<div>').addClass('panel-body').html(actionItem.action);
    if (CURRENT_IS_USER_MODERATOR) {
      panelBody.append($('<i>').addClass('fa fa-trash remove-action-item pull-right'));
    }

    panel.append(panelBody);

    $('#action-items').prepend(panel)
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/action_items/deleted', function(actionItem) {
    $('.action-item').each(function() {
      var $this = $(this);
      if ($this.data('actionItem').id == actionItem.id) {
        $this.remove();
      }
    });
  });
}

$(function() {
  if (RETRO) {
    subscribeForRetroActionItems();
  }

  $('form#new_action_item').submit(function(e) {
    e.preventDefault();
    var $this = $(this);
    var actionItem = $this.serializeObject().action_item;

    if (!$.isEmptyObject(actionItem.action)) {
      actionItem.retrospective_id = RETRO.id;
      CLIENT.publish('/action_items/create', { action_item: actionItem });

      $('input[type=text]').val('');
    }
  });

  $('#action-items').on('click', '.action-item .remove-action-item', function() {
    var $this = $(this);
    var actionItem = $this.parents('.action-item').data('actionItem');

    CLIENT.publish('/action_items/delete', { id: actionItem.id });
  });

});