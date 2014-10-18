$(function() {
  ZeroClipboard.config({
    moviePath: '//cdnjs.cloudflare.com/ajax/libs/zeroclipboard/1.3.2/ZeroClipboard.swf',
    trustedDomains: ['*'],
    allowScripAccess: 'always',
    forceHandCursor: true
  });

  var clip = new ZeroClipboard($('#shareModal a.copy'));

  clip.on( "load", function(client) {
    client.on("mousedown", function(client) {
      client.setText($('#shareModal .share-link span').text());
    });
  } );
});