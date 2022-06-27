import 'package:flutter_app3/core/api/api_consumer.dart';
import 'package:flutter_app3/core/api/end_points.dart';
import 'package:flutter_app3/features/quote/data/models/quote_model.dart';


abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;
  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuote);

    return QuoteModel.fromJson(response);
  }
}
