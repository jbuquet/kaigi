$(function() {
  CLIENT.subscribe('/stickies/created', function(sticky) {
    var span = $('<span>').addClass('sticky label label-primary')
                          .html(sticky.id + ' ' + sticky.body)
                          .data({ sticky: sticky });

    var icon = $('<i>').addClass('glyphicon glyphicon-remove remove-sticky');
    span.append(icon);

    $('#stickies').append(span);
  });

  CLIENT.subscribe('/stickies/deleted', function(sticky) {
    console.log('Sticky deleted ' + sticky.id + ', do something or delete!.');
  });

  $('form#new_sticky').submit(function(e) {
    e.preventDefault();

    var $this = $(this);
    var sticky = $this.serializeObject().sticky;

    CLIENT.publish('/stickies/create', { sticky: sticky });

    $this.find('textarea').val('');
  });

  $('#stickies').on('click', '.sticky .remove-sticky', function() {
    var $this = $(this);

    var sticky = $this.parents('.sticky').data('sticky');
    CLIENT.publish('/stickies/delete', { id: sticky.id });

    $this.parents('.sticky').remove();
  });

});