import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/themes.class.dart';
import '../../models/praytime.model.dart';

class TimePassedWidget extends StatelessWidget {
  const TimePassedWidget(this.item, {super.key});
  final PrayTime item;

  parseTime(String time) {
    int hours = int.parse(time[0] + time[1]);

    if (hours > 12) {
      hours -= 12;
      return '0$hours:${time[3]}${time[4]}';
    }
    return time;
  }

  ampm(String time) {
    int hours = int.parse(time[0] + time[1]);
    if (hours > 12) {
      return 'PM';
    }
    return 'AM';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Themes.primary.withOpacity(.3),
        boxShadow: const [
          BoxShadow(
            color: Colors.white30,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.title.tr,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Themes.textColor,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ampm(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(width: 5),
              Text(
                parseTime(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeNextWidget extends StatelessWidget {
  const TimeNextWidget(this.item, {super.key});
  final PrayTime item;

  parseTime(String time) {
    int hours = int.parse(time[0] + time[1]);

    if (hours > 12) {
      hours -= 12;
      return '0$hours:${time[3]}${time[4]}';
    }
    return time;
  }

  ampm(String time) {
    int hours = int.parse(time[0] + time[1]);
    if (hours > 12) {
      return 'PM';
    }
    return 'AM';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Themes.primary.withOpacity(.3),
        boxShadow: const [
          BoxShadow(
            color: Colors.white60,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.title.tr,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Themes.textColor,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ampm(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(width: 5),
              Text(
                parseTime(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeCurrentWidget extends StatelessWidget {
  const TimeCurrentWidget(this.item, {super.key});
  final PrayTime item;

  parseTime(String time) {
    int hours = int.parse(time[0] + time[1]);

    if (hours > 12) {
      hours -= 12;
      return '0$hours:${time[3]}${time[4]}';
    }
    return time;
  }

  ampm(String time) {
    int hours = int.parse(time[0] + time[1]);
    if (hours > 12) {
      return 'PM';
    }
    return 'AM';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Themes.selected,
              boxShadow: [
                Themes.cardShadow(),
              ],
            ),
            child: Text(
              item.title.tr,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Themes.textColor,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Themes.selected,
            boxShadow: [
              Themes.cardShadow(),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ampm(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(width: 5),
              Text(
                parseTime(item.time),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColor,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
