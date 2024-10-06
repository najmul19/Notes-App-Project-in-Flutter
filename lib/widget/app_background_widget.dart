

import 'dart:ui';

import 'package:flutter/material.dart';

class AppBackgroundWidget extends StatelessWidget {
  final Widget child;
  const AppBackgroundWidget({
    super.key,
    required this.child,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/back2.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0,sigmaY: 4.0),
          child: child),
    );
  }
}
