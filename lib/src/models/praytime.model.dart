class PrayTime {
  final int id;
  final String title;
  final String time;

  PrayTime(this.id, this.title, this.time);

  @override
  String toString() {
    return '$title - $time';
  }

  hours() {
    return int.parse(time[0] + time[1]);
  }

  minutes() {
    return int.parse(time[3] + time[4]);
  }

  getDateTime(DateTime now) {
    return DateTime(now.year, now.month, now.day, hours(), minutes());
  }
}
