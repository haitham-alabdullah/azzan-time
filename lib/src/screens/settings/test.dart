// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../models/language.model.dart';
// import '../../providers/main.provider.dart';

// class SelectMenuLanguages extends StatefulWidget {
//   const SelectMenuLanguages({
//     super.key,
//   });

//   @override
//   State<SelectMenuLanguages> createState() => _SelectMenuLanguagesState();
// }

// class _SelectMenuLanguagesState extends State<SelectMenuLanguages> {
//   late Language dropdownValue;

//   @override
//   void initState() {
//     dropdownValue = Get.find<MainProvider>().lang;
//     // title: 'Language',
//     //               def: provider.lang,
//     //               list: provider.languages,
//     //               onChange: provider.toggleLang,
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     قثفعقى Expanded(
//       child: DropdownButton<T>(
//           value: dropdownValue,
//           elevation: 2,
//           isExpanded: true,
//           underline: null,
//           iconSize: 25,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           items: widget.list.map<DropdownMenuItem<T>>((value) {
//             return DropdownMenuItem<T>(
//               value: value,
//               child: Text(
//                 value.title.toString().tr,
//                 style: const TextStyle(fontSize: 20),
//               ),
//             );
//           }).toList(),
//           onChanged: (dynamic newValue) {
//             setState(() {
//               dropdownValue = newValue! as T;
//             });
//             widget.onChange(dropdownValue);
//           }),
//     ),
//   }
// }
