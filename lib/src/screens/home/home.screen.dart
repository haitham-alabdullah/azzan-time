import 'package:flutter/material.dart';

import 'date.widget.dart';
import 'timing.widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DateWidget(),
              SizedBox(height: 20),
              TimingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
