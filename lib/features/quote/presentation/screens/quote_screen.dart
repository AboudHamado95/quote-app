import 'package:flutter/material.dart';
import 'package:flutter_app3/features/quote/config/locale/app_localizations.dart';
import 'package:flutter_app3/features/quote/core/utils/app_colors.dart';
import 'package:flutter_app3/features/quote/core/utils/app_strings.dart';
import 'package:flutter_app3/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:flutter_app3/features/quote/presentation/cubit/quote_state.dart';
import 'package:flutter_app3/features/quote/presentation/widgets/quote_content.dart';
import 'package:flutter_app3/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() {
    BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  }

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: (context, state) {
      if (state is RandomQuoteIsLoading) {
        return Center(child: SpinKitFadingCircle(color: AppColors.primary));
      } else if (state is RandomQuoteError) {
        return const Text('');
      } else if (state is RandomQuoteLoaded) {
        return Column(
          children: [
            QuoteContent(quote: state.quote),
            InkWell(
              onTap: () => _getRandomQuote(),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: const Icon(
                    Icons.refresh,
                    size: 28.0,
                    color: Colors.white,
                  )),
            ),
          ],
        );
      } else {
        return const Text('Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          if (AppLocalizations.of(context)!.isEnLocale)
            BlocProvider.of<LocaleCubit>(context).toArabic();
          else
            BlocProvider.of<LocaleCubit>(context).toEnglish();
        },
        icon: Icon(
          Icons.translate_outlined,
          color: AppColors.primary,
        ),
      ),
      title: Text(AppLocalizations.of(context)!.translate('app_name')!),
    );
    return RefreshIndicator(
        onRefresh: _getRandomQuote(),
        child: Scaffold(appBar: appBar, body: _buildBodyContent()));
  }
}
