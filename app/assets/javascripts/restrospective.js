function reloadStickies(){
  $('.sticky').droppable({
    accept: function(el){
      return el.hasClass('single');
    },
    drop: function(event, ui){
      console.log('sticky');
      groupSticky($(this), ui.draggable);
    }
  });

  $('.single').draggable({
    cancel: 'a.icon',
    revert: 'invalid',
    containment: 'document',
    helper: 'clone',
    cursor: 'move',
    greedy: true

  });

  $('.grouped').draggable({
    cancel: 'a.icon',
    revert: 'invalid',
    containment: 'document',
    helper: 'clone',
    cursor: 'move',
    greedy: true
  });

  $('.sticky').textfill({
    minFontPixels: 4,
    maxFontPixels: 40,
    explicitWidth: 165,
    explicitHeight: 165,
    innerTag: 'p'
  });
}

function createSticky($elem){
  var newSticky = "<li class='sticky single'><ul class='sticky-container'></ul><p></p></li>";
  $(newSticky).insertBefore($elem);

  $elem.prev().addClass('good');
  $elem.prev().find('p').text($elem.find('textarea').val());
  $elem.find('textarea').val('');

  reloadStickies();
}

function ungroupSticky($item) {
  $item.fadeOut(function() {
    $item.css('width', '200px').end().appendTo($('.container-sticky')).fadeIn();
  })
}

function groupSticky($elem, $item) {

  if(!$elem.hasClass('grouped')){
    $elem.addClass('group-color').removeClass('single');
  }

  $item.removeClass('sticky');

  $item.fadeOut(function() {
    $item.find('ul').remove();
    var $list = $elem.find('ul');
    $item.css({ width: '48px', height: '48px' }).removeClass('single').addClass('grouped');
    $item.appendTo( $list ).fadeIn();
  });
}

$( document ).ready(function() {

  reloadStickies();

  $('.container-sticky').droppable({
    accept: '.grouped',
    drop: function(event, ui) {
      console.log('container');
      ungroupSticky(ui.draggable);
    }
  });

  $('.new-sticky').bind('keypress', function(e) {
    if ((e.keyCode || e.which) == 13) {
//      $(this).parents('form').submit()
      createSticky($(this));
      return false;
    }
  });

});