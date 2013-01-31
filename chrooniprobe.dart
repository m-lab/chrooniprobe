import 'dart:html';
import 'package:web_ui/watcher.dart' as watchers;

String currentTime;
String testResolver;
String testSite;

ButtonElement startDNSTamperButton;
ButtonElement startHTTPRequestsButton;

void main() {
  startDNSTamperButton = query("#start-dnstamper");
  startHTTPRequestsButton = query("#start-httprequests");

  window.setInterval(updateTime, 1000);
  updateTime();
}

void startDNSTamper() {
  var results = query('#results-dnstamper');
  results.innerHtml.clear();
  setButtonStates(false);
  window.setInterval(function() {
    results.innerHtml = 'Ran against $testResolver';
    setButtonStates(true);
  }, 3000);
}

void startHTTPRequests() {
  var results = query('#results-httprequests');
  results.innerHtml.clear();
  setButtonStates(false);
  window.setInterval(function() {
    results.innerHtml = 'Ran against $testSite';
    setButtonStates(true);
  }, 3000);
}

void updateTime() {
  Date today = new Date.now();
  currentTime = formatTime(today.hour, today.minute, today.second);
  watchers.dispatch();
}

String formatTime(int h, int m, int s) {
  String hour = (h <= 9) ? '0$h' : '$h';
  String minute = (m <= 9) ? '0$m' : '$m';
  String second = (s <= 9) ? '0$s' : '$s';
  return '$hour:$minute:$second';
}

void setButtonStates(bool enabled) {
  startDNSTamperButton.disabled = !enabled;
  startHTTPRequestsButton.disabled = !enabled;
}
