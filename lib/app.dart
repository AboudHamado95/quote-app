import 'package:flutter/material.dart';
import 'package:flutter_app3/config/locale/app_localizations_setup.dart';
import 'package:flutter_app3/config/routes/app_routes.dart';
import 'package:flutter_app3/config/themes/app_theme.dart';
import 'package:flutter_app3/core/utils/app_strings.dart';
import 'package:flutter_app3/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app3/features/splash/presentation/cubit/locale_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injection<LocaleCubit>()..getSavedLang(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            onGenerateRoute: AppRoute.onGenerateRoute,
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
          );
        },
      ),
    );
  }
}
