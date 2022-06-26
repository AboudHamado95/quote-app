import 'package:dartz/dartz.dart';

import 'package:flutter_app3/features/quote/core/errors/failures.dart';
import 'package:flutter_app3/features/quote/core/usecases/usecases.dart';
import 'package:flutter_app3/features/splash/domain/repositories/lang_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;
  GetSavedLangUseCase({
    required this.langRepository,
  });
  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await langRepository.getSavedLang();
}
