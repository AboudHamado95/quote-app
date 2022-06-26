import 'package:flutter/material.dart';
import 'package:flutter_app3/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_app3/injection_container.dart';
import 'package:flutter_app3/features/quote/core/utils/app_strings.dart';
import 'package:flutter_app3/features/quote/presentation/screens/quote_screen.dart';
import 'package:flutter_app3/features/quote/presentation/cubit/quote_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRoute = '/randomQuote';
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: ((context) => const SplashScreen()),
        );

      case Routes.randomQuoteRoute:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => injection<RandomQuoteCubit>(),
                child: const QuoteScreen(),
              )),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text(AppStrings.appName)),
      ),
    );
  }
}
