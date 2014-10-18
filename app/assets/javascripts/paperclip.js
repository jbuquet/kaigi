$(function() {
  $('#shareModal a.copy').zclip({
    path: 'assets/ZeroClipboard.swf',
    copy: $('#shareModal .share-link span').text()
  });
});