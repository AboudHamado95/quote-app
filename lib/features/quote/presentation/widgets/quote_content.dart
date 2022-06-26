import 'package:flutter/material.dart';
import 'package:flutter_app3/features/quote/config/themes/app_theme.dart';
import 'package:flutter_app3/features/quote/core/utils/app_colors.dart';
import 'package:flutter_app3/features/quote/domain/entities/quote.dart';


class QuoteContent extends StatelessWidget {
  final Quote quote;
  const QuoteContent({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Column(
        children: [
          Text(quote.content,
              textAlign: TextAlign.center,
              style: appTheme().textTheme.displayMedium),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(quote.author)),
        ],
      ),
    );
  }
}
