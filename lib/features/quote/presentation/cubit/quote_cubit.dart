import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app3/features/quote/core/errors/failures.dart';
import 'package:flutter_app3/features/quote/core/usecases/usecases.dart';
import 'package:flutter_app3/features/quote/core/utils/app_strings.dart';
import 'package:flutter_app3/features/quote/domain/entities/quote.dart';
import 'package:flutter_app3/features/quote/domain/usecases/get_random_quote.dart';
import 'package:flutter_app3/features/quote/presentation/cubit/quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuoteInitial());
  Future<void> getRandomQuote() async {
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(response.fold(
        (failure) => RandomQuoteError(msg: _mapFailureToMsg(failure)),
        (quote) => RandomQuoteLoaded(quote: quote)));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
