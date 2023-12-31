import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/themes.class.dart';
import '../../packages/custom_dropdown.dart';

class SelectMenu<T> extends StatefulWidget {
  const SelectMenu({
    required this.title,
    required this.def,
    required this.list,
    required this.onChange,
    this.withSrearch = false,
    super.key,
  }) : assert(def is T && list is List<T>);

  final String title;
  final dynamic def;
  final List<dynamic> list;
  final void Function(T) onChange;
  final bool withSrearch;

  @override
  State<SelectMenu> createState() => _SelectMenuState<T>();
}

class _SelectMenuState<T> extends State<SelectMenu<T>> {
  late TextEditingController jobRoleCtrl;

  @override
  void initState() {
    jobRoleCtrl = TextEditingController(text: widget.def.title.toString());
    super.initState();
  }

  @override
  void dispose() {
    jobRoleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Get.locale == const Locale('en')
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                '${widget.title.tr}:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Themes.textColor,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: widget.withSrearch
                ? CustomDropdown.search(
                    hintText: widget.title.tr,
                    excludeSelected: false,
                    fillColor: Themes.selected,
                    items: widget.list.map((e) => e.title.toString()).toList(),
                    listItemBuilder: (context, result) {
                      return Text(
                        result.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Tajawal',
                          color: Themes.textColor,
                        ),
                      );
                    },
                    valueBuilder: (p0) => p0.tr,
                    controller: jobRoleCtrl,
                    selectedStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                      color: Themes.textColor,
                    ),
                    onChanged: (c) {
                      for (var element in widget.list) {
                        if (element.title == c) {
                          widget.onChange(element);
                          break;
                        }
                      }
                    })
                : CustomDropdown(
                    hintText: widget.title.tr,
                    excludeSelected: false,
                    fillColor: Themes.selected,
                    items: widget.list.map((e) => e.title.toString()).toList(),
                    listItemBuilder: (context, result) {
                      return Text(
                        result.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Tajawal',
                          color: Themes.textColor,
                        ),
                      );
                    },
                    valueBuilder: (p0) => p0.tr,
                    controller: jobRoleCtrl,
                    selectedStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Tajawal',
                      color: Themes.textColor,
                    ),
                    onChanged: (c) {
                      for (var element in widget.list) {
                        if (element.title == c) {
                          widget.onChange(element);
                          break;
                        }
                      }
                    }),
          ),
        ],
      ),
    );
  }
}
