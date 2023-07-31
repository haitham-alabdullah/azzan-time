import 'package:azzan/src/providers/main.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/themes.class.dart';
import '../screens/home/home.screen.dart';
import '../widgets/appbar.widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            opacity: .5,
            colorFilter: ColorFilter.mode(
              Themes.primary,
              BlendMode.colorDodge,
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<MainProvider>(builder: (controller) {
            return const HomeScreen();
          }),
        ),
      ),
    );
  }
}