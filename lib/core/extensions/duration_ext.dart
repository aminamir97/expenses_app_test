extension DurationStrExt on Duration {
  String get formatted {
    int secs = inSeconds;
    int mins = secs ~/ 60;
    secs = secs % 60;

    final minStr = '$mins'.padLeft(2, '0');
    final secStr = '$secs'.padLeft(2, '0');
    return '$minStr:$secStr';
  }
}
