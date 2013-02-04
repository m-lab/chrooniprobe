library chrooniprobe;

import 'dart:html';
import 'package:web_ui/watcher.dart' as watchers;
import 'socket.dart';

part 'oonitest.dart';
part 'tests/tcpconnect.dart';

final String DEFAULT_RESOLVER = '8.8.8.8';
final String DEFAULT_SITE = 'http://www.google.com';
final String DEFAULT_IPS = '8.8.8.8:53\n8.8.4.4:53';

String testResolver;
String testSite;
String testIPs;

List<OONITest> tests = [
  new OONITest('dnstamper', (test) {
    if (testResolver == null || testResolver.isEmpty) testResolver = DEFAULT_RESOLVER;
    test.log('Ran against $testResolver');
  }),
  new OONITest('httprequests', (test) {
    if (testSite == null || testSite.isEmpty) testSite = DEFAULT_SITE;
    test.log('Ran against $testSite');
  }),
  new OONITest('tcpconnect', (test) {
    if (testIPs == null || testIPs.isEmpty) testIPs = DEFAULT_IPS;
    testIPs.split('\n').forEach((testIP) => TCPConnect(test, testIP));
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

