part of chrooniprobe;

void TCPConnect(OONITest test, String ip) {
  var ipPort = ip.split(':');
  TcpClient client = new TcpClient(ipPort[0], int.parse(ipPort[1]));

  try {
    test.log('Attempting to connect to $ip');
    client.connect().then((connected) {
      if (connected)
        test.log('  Connected to $ip');
      else
        test.log('  Failed to connect to $ip', isError: true);
    });
  } catch(e) {
    test.log('$e', isError: true);
  }
}

