import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/themes.class.dart';
import '../providers/main.provider.dart';
import '../screens/home/home.screen.dart';
import '../screens/settings/settings.screen.dart';
import '../widgets/appbar.widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            opacity: .3,
            colorFilter: ColorFilter.mode(
              Themes.primary,
              BlendMode.colorDodge,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  'assets/images/bg2.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned.fill(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GetBuilder<MainProvider>(builder: (provider) {
                  return AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(animation),
                        child: child,
                      );
                    },
                    layoutBuilder: (currentChild, previousChildren) {
                      if (currentChild != null &&
                          currentChild.key == const ValueKey('settings')) {
                        return Expanded(child: currentChild);
                      }
                      return currentChild ?? const SizedBox();
                    },
                    duration: const Duration(milliseconds: 500),
                    child: provider.isSettings
                        ? const SettingsScreen(key: ValueKey('settings'))
                        : const HomeScreen(key: ValueKey('home')),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
