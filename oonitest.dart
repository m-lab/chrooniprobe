part of chrooniprobe;

class OONITest {
  OONITest(this.name, this.do_test) {
    button = query('#start-${this.name}');
    results = query('#results-${this.name}');
  }

  void run() {
    setButtonStates(false);
    results.innerHtml = '';
    do_test(this);
    setButtonStates(true);
  }

  void log(String message, {bool isError: false}) {
    // TODO: Add span with class 'resultError'.
    results.innerHtml = results.innerHtml.concat('$message<br/>');
  }

  String name;
  Function do_test;
  ButtonElement button;
  Element results;
}


