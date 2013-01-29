chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('out/index.html', {
    'id': 'chrooniprobe',
    'width': 400,
    'height': 500
  });
});
