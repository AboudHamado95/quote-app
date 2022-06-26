import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app3/features/quote/core/errors/failures.dart';
import 'package:flutter_app3/features/quote/core/usecases/usecases.dart';
import 'package:flutter_app3/features/quote/domain/entities/quote.dart';
import 'package:flutter_app3/features/quote/domain/repositories/quote_repository.dart';


class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository quoteRepository;
  GetRandomQuote({
    required this.quoteRepository,
  });

  @override
  Future<Either<Failure, Quote>> call(NoParams params) {
    return quoteRepository.getRandomQuote();
  }
}

class LoginParams extends Equatable {
  final String userName;
  final String password;

  const LoginParams({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [userName, password];
}
