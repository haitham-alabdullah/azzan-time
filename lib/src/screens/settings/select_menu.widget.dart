import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../classes/themes.class.dart';

class SelectMenu<T> extends StatefulWidget {
  const SelectMenu({
    required this.title,
    required this.def,
    required this.list,
    required this.onChange,
    super.key,
  }) : assert(def is T && list is List<T>);

  final String title;
  final dynamic def;
  final List<dynamic> list;
  final void Function(T) onChange;

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
            width: Get.width / 6,
            child: Text(
              '${widget.title.tr}: ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Themes.textColor,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomDropdown(
                hintText: widget.title.tr,
                excludeSelected: false,
                fillColor: Themes.selected,
                items: widget.list.map((e) => e.title.toString().tr).toList(),
                controller: jobRoleCtrl,
                selectedStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                  color: Themes.textColor,
                ),
                onChanged: (c) {
                  // onChange
                  for (var element in widget.list) {
                    if (element.title.toString().tr == c) {
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
