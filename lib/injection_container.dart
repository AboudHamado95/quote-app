import 'package:dio/dio.dart';
import 'package:flutter_app3/core/api/api_consumer.dart';
import 'package:flutter_app3/core/api/api_interceptors.dart';
import 'package:flutter_app3/core/api/dio_consumer.dart';
import 'package:flutter_app3/core/network/network_info.dart';
import 'package:flutter_app3/features/quote/data/datasources/random_quote_local_data_source.dart';
import 'package:flutter_app3/features/quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:flutter_app3/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:flutter_app3/features/quote/domain/repositories/quote_repository.dart';
import 'package:flutter_app3/features/quote/domain/usecases/get_random_quote.dart';
import 'package:flutter_app3/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:flutter_app3/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:flutter_app3/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:flutter_app3/features/splash/domain/repositories/lang_repository.dart';
import 'package:flutter_app3/features/splash/domain/usecases/change_lang.dart';
import 'package:flutter_app3/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:flutter_app3/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final injection = GetIt.instance;

Future<void> init() async {
  /// Features
  // Blocs
  injection.registerFactory(
      () => RandomQuoteCubit(getRandomQuoteUseCase: injection()));
  injection.registerFactory(() => LocaleCubit(
      changeLangUseCase: injection(), getSavedLangUseCase: injection()));
  // Use Cases
  injection.registerLazySingleton(
      () => GetRandomQuote(quoteRepository: injection()));
  injection.registerLazySingleton(
      () => ChangeLangUseCase(langRepository: injection()));
  injection.registerLazySingleton(
      () => GetSavedLangUseCase(langRepository: injection()));
  // Repository
  injection.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      networkInfo: injection(),
      randomQuoteLocalDataSource: injection(),
      randomQuoteRemoteDataSource: injection()));
  injection.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSourceImpl: injection()));
  // Data Sources
  injection.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: injection()));

  injection.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: injection()));

  injection.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: injection()));

  /// Core
  injection.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: injection()));

  injection.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: injection()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();

  injection.registerLazySingleton(() => sharedPreferences);

  injection.registerLazySingleton(() => AppInterceptors());

  injection.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));

  injection.registerLazySingleton(() => InternetConnectionChecker());

  injection.registerLazySingleton(() => Dio());
}
