import 'package:flutter/material.dart';
import 'package:flutter_app3/config/locale/app_localizations.dart';
import 'package:flutter_app3/core/utils/app_colors.dart';

class ErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const ErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 150.0,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppLocalizations.of(context)!.translate('something_went_wrong')!,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.translate('try_again')!,
          style: TextStyle(
              color: AppColors.hint,
              fontSize: 18.0,
              fontWeight: FontWeight.w500),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: AppColors.primary,
            elevation: 500,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.0)),
          ),
          child: Text(
            AppLocalizations.of(context)!.translate('reload_screen')!,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (onPress != null) onPress!();
          },
        ),
      ],
    );
  }
}
