import 'package:dartz/dartz.dart';
import 'package:flutter_app3/core/errors/exceptions.dart';

import 'package:flutter_app3/core/errors/failures.dart';
import 'package:flutter_app3/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:flutter_app3/features/splash/domain/repositories/lang_repository.dart';

class LangRepositoryImpl implements LangRepository {
  final LangLocalDataSourceImpl langLocalDataSourceImpl;
  LangRepositoryImpl({required this.langLocalDataSourceImpl});
  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged =
          await langLocalDataSourceImpl.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocalDataSourceImpl.getSavedLang();
      return Right(langCode.toString());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
