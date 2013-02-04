library chrooniprobe;

import 'dart:html';
import 'package:web_ui/watcher.dart' as watchers;
import 'socket.dart';
import 'mlab.dart' as mlab;

part 'oonitest.dart';
part 'tests/dnstamper.dart';
part 'tests/httprequests.dart';
part 'tests/tcpconnect.dart';

final String DEFAULT_RESOLVER = '8.8.8.8';
final String DEFAULT_SITE = 'http://www.google.com';
final String DEFAULT_IPS = '8.8.8.8:53\n8.8.4.4:53';
final String DEFALT_TOOL = 'ndt';

String testTool;
String testResolver;
String testSite;
String testIPs;

void MLabNS(test, testTool) {
  mlab.lookup(testTool).then((response) {
      test.log('${response["fqdn"]}: ${response["ip"]}');
  });
}

List<OONITest> tests = [
  new OONITest('mlab-ns', (test) {
    if (testTool == null || testTool.isEmpty) testTool = 'ndt';
    MLabNS(test, testTool);
  }),
  new OONITest('dnstamper', (test) {
    if (testResolver == null || testResolver.isEmpty) testResolver = DEFAULT_RESOLVER;
    DNSTamper(test, testResolver);
  }),
  new OONITest('httprequests', (test) {
    if (testSite == null || testSite.isEmpty) testSite = DEFAULT_SITE;
    HTTPRequests(test, testSite);
  }),
  new OONITest('tcpconnect', (test) {
    if (testIPs == null || testIPs.isEmpty) testIPs = DEFAULT_IPS;
    testIPs.split('\n').forEach((testIP) => TCPConnect(test, testIP));
  }),
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

