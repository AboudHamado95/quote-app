import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/controllers/task_controller.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:flutter_app3/services/notification_services.dart';
import 'package:flutter_app3/services/theme_services.dart';
import 'package:flutter_app3/ui/pages/add_task_page.dart';
import 'package:flutter_app3/ui/size_config.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:flutter_app3/ui/widgets/button.dart';
import 'package:flutter_app3/ui/widgets/input_field.dart';
import 'package:flutter_app3/ui/widgets/task_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    taskController.getTasks();
  }

  final TaskController taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              ThemeServices().switchTheme();
            },
            icon: Icon(Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined),
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {
                notifyHelper.cancelAllNotification();
                taskController.deleteAllTasks();
              },
              icon: Icon(
                Icons.cleaning_services_outlined,
                size: 24.0,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.jpeg'),
              radius: 18.0,
            ),
            const SizedBox(
              width: 20.0,
            )
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: subTitleStyle,
                    ),
                    Text(
                      'Today',
                      style: headingStyle,
                    )
                  ],
                ),
                MyButton(
                    label: 'Add Task',
                    onTap: () async {
                      await taskController.getTasks();
                      await Get.to(() => const AddTaskPage());
                    }),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(
              top: 6.0,
            ),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              width: 60.0,
              height: 100.0,
              selectedTextColor: Colors.white,
              selectionColor: primaryClr,
              dateTextStyle: titleStyle.copyWith(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
              dayTextStyle: titleStyle.copyWith(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
              monthTextStyle: titleStyle.copyWith(
                  fontSize: 12.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
              onDateChange: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          showTasks(),
        ],
      ),
    );
  }

  showTasks() {
    return Obx(
      () {
        if (taskController.taskList.isEmpty) {
          return noTaskMsg();
        } else {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var task = taskController.taskList[index];
                var date = DateFormat.jm().parse(task.startTime!);
                var myTime = DateFormat('HH:mm').format(date);
                notifyHelper.scheduledNotification(
                    hour: int.parse(myTime.toString().split(':')[0]),
                    minutes: int.parse(myTime.toString().split(':')[1]),
                    task: task);
                if (task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            selectedDate.day)) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            notifyHelper.scheduledNotification(
                                hour:
                                    int.parse(myTime.toString().split(':')[0]),
                                minutes:
                                    int.parse(myTime.toString().split(':')[1]),
                                task: task);
                            showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: taskController.taskList.length,
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
            ),
          );
        }
      },
    );
  }

  Widget noTaskMsg() {
    return Expanded(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 6.0)
                      : const SizedBox(height: 6),
                  SvgPicture.asset(
                    'assets/images/task.svg',
                    height: 90.0,
                    semanticsLabel: 'Task',
                    color: primaryClr.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Text(
                      'You do not have any yet!\nAdd new tasks to make your days productive',
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 120.0)
                      : const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4.0),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.3
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6.0,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              const SizedBox(height: 20.0),
              task.isCompleted == 1
                  ? Container()
                  : buildBottomSheet(
                      label: 'Task Completed',
                      onTap: () {
                        taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      color: primaryClr),
              buildBottomSheet(
                  label: 'Delete Task',
                  onTap: () {
                    notifyHelper.cancelNotification(task);
                    taskController.deleteTasks(task);
                    Get.back();
                  },
                  color: primaryClr),
              Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              buildBottomSheet(
                  label: 'Cancel', onTap: () => Get.back(), color: primaryClr),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBottomSheet({
  required String label,
  required Function() onTap,
  required Color color,
  bool isClose = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      height: 65.0,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20.0),
          color: isClose ? Colors.transparent : color),
      child: Center(
        child: Text(
          label,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}
