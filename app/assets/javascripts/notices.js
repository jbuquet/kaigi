$(function(){
  $('[data-dismiss="alert"]').click(function(){
    var notice = $(this).data('name');
    document.cookie = notice + "-hidden=true";
  });

  $('[data-dismiss="alert"]').each(function(){
    var notice = $(this).data('name');

    if (!$.isEmptyObject(notice)) {
      if (!$.isEmptyObject($.cookie(notice + '-hidden'))) {
        $(this).parents('.alert').addClass('hide');
      }
    }
  });
});