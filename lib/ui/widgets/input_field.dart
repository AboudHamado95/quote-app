import 'package:flutter/material.dart';
import 'package:flutter_app3/ui/size_config.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: subTitleStyle),
          Container(
            padding: const EdgeInsets.only(left: 14.0),
            margin: const EdgeInsets.only(top: 8.0),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    autofocus: false,
                    readOnly: widget != null ? true : false,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: bodyStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.theme.backgroundColor),
                      ),
                    ),
                  ),
                ),
                widget ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
