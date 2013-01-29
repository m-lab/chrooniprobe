String currentTime;

void main() {
  Date today = new Date.now();
  currentTime = formatTime(today.hour, today.minute, today.second);
}

String formatTime(int h, int m, int s) {
  String hour = (h <= 9) ? '0$h' : '$h';
  String minute = (m <= 9) ? '0$m' : '$m';
  String second = (s <= 9) ? '0$s' : '$s';
  return '$hour:$minute:$second';
}
