function subscribeForRetroStickies() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/stickies/created', function(sticky) {
    var span = $('<span>').addClass('sticky label label-primary')
      .html(sticky.id + ' ' + sticky.body)
      .data({ sticky: sticky });

    var icon = $('<i>').addClass('glyphicon glyphicon-remove remove-sticky');
    span.append(icon);

    $('#stickies').append(span);
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/stickies/deleted', function(sticky) {
    $('#stickies .sticky').each(function() {
      var $this = $(this);
      if ($this.data('sticky').id == sticky.id) {
        $this.remove();
      }
    })
  });
}

$(function() {
  if (RETRO) {
    subscribeForRetroStickies();
  }

  $('form#new_sticky').submit(function(e) {
    e.preventDefault();

    var $this = $(this);
    var sticky = $this.serializeObject().sticky;
    sticky.retrospective_id = RETRO.id;

    CLIENT.publish('/stickies/create', { sticky: sticky });

    $this.find('textarea').val('');
  });

  $('#stickies').on('click', '.sticky .remove-sticky', function() {
    var $this = $(this);

    var sticky = $this.parents('.sticky').data('sticky');
    CLIENT.publish('/stickies/delete', { id: sticky.id });
  });

});