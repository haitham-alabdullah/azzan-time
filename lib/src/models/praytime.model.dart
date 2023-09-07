import 'dart:convert';

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

  String storeString() {
    return jsonEncode({
      'id': id,
      'title': title,
      'time': time,
    });
  }

  factory PrayTime.fromString(String time) {
    final times = jsonDecode(time);
    return PrayTime(
      times['id'],
      times['title'],
      times['time'],
    );
  }

  @override
  bool operator ==(other) {
    return other is PrayTime &&
        id == other.id &&
        title == other.title &&
        time == other.time;
  }
}
