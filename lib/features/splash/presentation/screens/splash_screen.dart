import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app3/features/quote/config/routes/app_routes.dart';
import 'package:flutter_app3/features/quote/core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.randomQuoteRoute);
  }

  _startDelay() {
    _timer = Timer(
      const Duration(milliseconds: 2000),
      () => _goNext(),
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImgAssets.quote),
      ),
    );
  }
}
