$(function() {
  var schema = 'http://';
  var uri = schema + window.document.location.host + '/socket';
  CLIENT = new Faye.Client(uri);
});