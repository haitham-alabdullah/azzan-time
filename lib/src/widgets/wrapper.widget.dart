import 'package:flutter/material.dart';

import '../classes/themes.class.dart';
import 'appbar.widget.dart';

class WrapperWidget extends StatelessWidget {
  const WrapperWidget(this.child, {super.key});
  final Widget child;

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
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
