import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../classes/services.class.dart';
import '../../classes/themes.class.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  Widget getDay({String local = 'en'}) {
    final day = DateTime.now().weekday - 1;
    final ar = [
      'الأثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    final en = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return Text(
      local == 'ar' ? ar[day] : en[day],
      style: const TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Themes.textColor,
      ),
    );
  }

  Widget getMDate() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;
    final enDate = ' $day / $month / $year M';
    return Text(
      enDate.toString(),
      style: const TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Themes.textColor,
      ),
      textDirection: TextDirection.ltr,
    );
  }

  Widget getHDate() {
    final day = HijriCalendar.now().hDay;
    final month = HijriCalendar.now().hMonth;
    final year = HijriCalendar.now().hYear;
    final enDate = Services.toArNumber('$day / $month / $year هـ');

    return Text(
      enDate.toString(),
      style: const TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Themes.textColor,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  getMonth({String local = 'en'}) {
    int month =
        local == 'en' ? DateTime.now().month : HijriCalendar.now().hMonth;
    final ar = [
      '',
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];
    final en = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return Text(
      local == 'en' ? en[month] : ar[month],
      style: const TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Themes.textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Themes.primary.withOpacity(.3),
        boxShadow: const [
          BoxShadow(
            color: Colors.white54,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getDay(local: 'ar'),
              const SizedBox(height: 10),
              getHDate(),
              const SizedBox(height: 10),
              getMonth(local: 'ar'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getDay(local: 'en'),
              const SizedBox(height: 10),
              getMDate(),
              const SizedBox(height: 10),
              getMonth(local: 'en'),
            ],
          ),
        ],
      ),
    );
  }
}
