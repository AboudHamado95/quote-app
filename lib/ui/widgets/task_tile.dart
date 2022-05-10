import 'package:flutter/material.dart';

import 'package:flutter_app3/models/task.dart';
import 'package:flutter_app3/ui/size_config.dart';
import 'package:flutter_app3/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
            SizeConfig.orientation == Orientation.landscape ? 4 : 20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12.0)),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: _getBackgroundColor(task.color!)),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  task.title!,
                  style:
                      titleStyle.copyWith(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18.0,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      '${task.startTime!} - ${task.endTime!}',
                      style: titleStyle.copyWith(
                          color: Colors.grey[100],
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(task.note!),
              ]),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 60.0,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: titleStyle.copyWith(color: Colors.white, fontSize: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBackgroundColor(int color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return pinkClr;
    }
  }
}
