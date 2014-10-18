function subscribeForRetroStickies() {
  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/stickies/created', function(sticky) {
    createSticky($('.new-sticky'), sticky);
  });

  CLIENT.subscribe('/retrospectives/' + RETRO.id + '/stickies/deleted', function(sticky) {
    $('#stickies .sticky').each(function() {
      var $this = $(this);
      if ($this.data('sticky').id == sticky.id) {
        $this.remove();
      }
    });
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
    ['bad', 'good', 'idea'].each(function(index){
      if($this.hasClass(index)){
        sticky.sticky_type = index;
      }
    });
    sticky.retrospective_id = RETRO.id;
    sticky.user_id = USER.id;


    CLIENT.publish('/stickies/create', { sticky: sticky });

    $this.find('textarea').val('');
  });

  $('#stickies').on('click', '.sticky .remove-sticky', function() {
    var $this = $(this);
    var sticky = $this.parents('.sticky').data('sticky');
    CLIENT.publish('/stickies/delete', { id: sticky.id });
  });
});