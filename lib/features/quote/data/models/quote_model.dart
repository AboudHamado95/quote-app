import 'package:flutter_app3/features/quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel(
      {required String author,
      required int id,
      required String content,
      required String permalink})
      : super(
            author: author, id: id, content: content, permalink: permalink);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'permalink': permalink,
    };
  }

  factory QuoteModel.fromJson(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id']?.toInt() ?? 0,
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      permalink: map['permalink'] ?? '',
    );
  }
}
