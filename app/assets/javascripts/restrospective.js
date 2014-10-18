GOOD_STICKY = 'good';
IDEA_STICKY = 'idea';
BAD_STICKY = 'bad';

function reloadStickies(){

  $('.sticky').droppable({
    accept: function(el){
      return el.hasClass('single');
    },
    drop: function(event, ui) {
      groupSticky($(this), ui.draggable);
    }
  });

  $('li.single, li.grouped, li.group-color').draggable({
    cancel: 'a.icon',
    revert: 'invalid',
    containment: 'document',
    helper: 'clone',
    cursor: 'move',
    greedy: true

  });

  $('.sticky').textfill({
    minFontPixels: 4,
    maxFontPixels: 32,
    explicitWidth: 165,
    explicitHeight: 140,
    innerTag: 'p'
  });

  $('.grouped').addClass('sticky-min')
}

function createSticky($elem, sticky){
  var newSticky = $("<li>").addClass('sticky single').addClass(sticky.sticky_type).data({ sticky: sticky });
  var initial = $('<span>').addClass('pull-left user-initial')
                           .css('background-color', sticky.user.color)
                           .text(userInitial(sticky.user));
  newSticky.append(initial);
  newSticky.append($('<i>').addClass('fa fa-trash remove-sticky pull-right'));
  newSticky.append($("<ul>").addClass('sticky-container'));
  newSticky.append($("<p>").text(sticky.body));
  newSticky.addClass($elem.attr('class')).removeClass('new-sticky');

  $(newSticky).insertAfter($elem);
  $elem.attr('class', 'new-sticky new');
  reloadStickies();
}

function ungroupSticky($item) {
  $item.fadeOut(function() {
    $item.css('width', '200px').end().appendTo($('.container-stickies')).fadeIn();
  })
}

function drawGroupSticky($elem, $item) {
  if(!$elem.hasClass('grouped')){
    $elem.addClass('group-color').removeClass('single');
    $elem.find('.remove-sticky').remove();
    $elem.find('.user-initial').remove();
  }

  $item.fadeOut(function() {
    $item.removeClass('sticky');
    $item.find('ul').remove();
    var $list = $elem.find('ul');
    $item.addClass('sticky-min').removeClass('single').addClass('grouped');
    $item.find('.remove-sticky').remove();
    $item.find('.user-initial').remove();
    $item.appendTo( $list ).fadeIn();
  });
}

function hasTypeSelected(elem){
  return elem.is('.good, .bad, .idea')
}

$( document ).ready(function() {

  reloadStickies();

  $('.container-stickies').droppable({
    accept: '.grouped',
    drop: function(event, ui) {
      ungroupSticky(ui.draggable);
    }
  });

  $('.new-sticky').bind('keypress', function(e) {
    if ((e.keyCode || e.which) == 13) {
      var sticky = {
        body: $(this).find("textarea").val(),
        retrospective_id: RETRO.id,
        user_id: USER.id,
        sticky_type: $(this).data('type')
      };


      if(hasTypeSelected($(this))){
        $(this).find("textarea").val("");
        CLIENT.publish('/stickies/create', { sticky: sticky });
      }
      return false;
    }
  });

  $('.new-sticky').tooltip();

  $('#settings-btn').bind('click', function(e) {
    $('.settings-container').toggle();

    var $settings_btn = $('#settings-btn').find('i');

    if ($settings_btn.hasClass('fa-cog')) {
      $settings_btn.removeClass('fa-cog');
      $settings_btn.addClass('fa-close');
    } else if ($settings_btn.hasClass('fa-close')) {
      $settings_btn.removeClass('fa-close');
      $settings_btn.addClass('fa-cog');
    }
  });

  $('.good-type').on('click', function(event){
    $('.new-sticky').attr('class', 'new-sticky').addClass(GOOD_STICKY).data('type', GOOD_STICKY);
    $('.sticky-text').focus();
  })

  $('.idea-type').on('click', function(event){
    $('.new-sticky').attr('class', 'new-sticky').addClass(IDEA_STICKY).data('type', IDEA_STICKY);
    $('.sticky-text').focus();
  })

  $('.bad-type').on('click', function(event){
    $('.new-sticky').attr('class', 'new-sticky').addClass(BAD_STICKY).data('type', BAD_STICKY);
    $('.sticky-text').focus();
  })

});