import 'package:azzan/src/providers/main.provider.dart';
import 'package:azzan/src/widgets/loading.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../classes/themes.class.dart';
import '../providers/time.provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? 'Azzan Time'.tr,
        style: Themes.textStyle.copyWith(fontWeight: FontWeight.w800),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        GetBuilder<TimeProvider>(builder: (provider) {
          return Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.all(10.5),
            decoration: BoxDecoration(
              color: Themes.bg,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: provider.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(10.5),
                    child: Loading(),
                  )
                : Image.asset('assets/images/logo.png'),
          );
        }),
      ],
      leading: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.all(10.5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: GetBuilder<MainProvider>(builder: (provider) {
          return IconButton(
            onPressed: provider.toggleSettings,
            constraints: const BoxConstraints(maxHeight: 35, maxWidth: 35),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: provider.isSettings
                  ? const Icon(
                      Icons.close_rounded,
                      size: 15,
                      key: ValueKey('icon1'),
                    )
                  : const Icon(
                      Icons.settings_rounded,
                      size: 15,
                    ),
            ),
            splashRadius: 50,
            style: IconButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              backgroundColor: Themes.bg,
              shadowColor: Colors.black26,
            ),
          );
        }),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Themes.bg,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Themes.bg,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
