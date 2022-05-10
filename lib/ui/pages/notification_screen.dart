import 'package:flutter/material.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';

  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 20.0),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Column(
              children: [
                Text(
                  'Hello, Aboud!',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'You have a new reminder',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: primaryClr),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Row(
                        children: const [
                          Icon(
                            Icons.text_format,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Title',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        _payload.toString().split('|')[0],
                        style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16.0),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: const [
                          Icon(
                            Icons.description,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Description',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        _payload.toString().split('|')[1],
                        style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16.0),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Date',
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.0),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        _payload.toString().split('|')[2],
                        style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      )),
    );
  }
}
