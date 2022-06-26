import 'package:dartz/dartz.dart';

import 'package:flutter_app3/features/quote/core/errors/failures.dart';
import 'package:flutter_app3/features/quote/core/usecases/usecases.dart';
import 'package:flutter_app3/features/splash/domain/repositories/lang_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;
  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}
