import 'dart:html';
import 'package:web_ui/watcher.dart' as watchers;

final String DEFAULT_RESOLVER = '8.8.8.8';
final String DEFAULT_SITE = 'http://www.google.com';
final String DEFAULT_IPS = '8.8.8.8:53\n8.8.4.4:53';

String testResolver;
String testSite;
String testIPs;

class OONITest {
  OONITest(this.name, this.do_test) {
    button = query('#start-${this.name}');
    results = query('#results-${this.name}');
  }

  void run() {
    setButtonStates(false);
    results.innerHtml = '';
    do_test(results);
    setButtonStates(true);
  }

  String name;
  Function do_test;
  ButtonElement button;
  Element results;
}

List<OONITest> tests = [
  new OONITest('dnstamper', (results) {
      if (testResolver == null || testResolver.isEmpty) testResolver = DEFAULT_RESOLVER;
      results.innerHtml = 'Ran against $testResolver';
  }),
  new OONITest('httprequests', (results) {
      if (testSite == null || testSite.isEmpty) testSite = DEFAULT_SITE;
      results.innerHtml = 'Ran against $testSite';
  }),
  new OONITest('tcpconnect', (results) {
      if (testIPs == null || testIPs.isEmpty) testIPs = DEFAULT_IPS;
      var ipList = testIPs.split('\n');
      ipList.forEach((testIP) {
          results.innerHtml = results.innerHtml.concat('Ran against $testIP<br/>');
      });
  })
];

void start(String testname) {
  tests.where((test) => test.name == testname).forEach((test) => test.run());
}

void setButtonStates(bool enabled) {
  tests.forEach((test) => test.button.disabled = !enabled);
}

void main() {
  window.setInterval(updateTime, 1000);
  updateTime();
}

String currentTime;

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

