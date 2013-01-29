chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('_index.html.html', {
    'width': 400,
    'height': 500
  });
});
