import 'package:flutter/material.dart';
import 'package:flutter_app3/models/task.dart';
import 'package:flutter_app3/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_app3/controllers/task_controller.dart';
import 'package:flutter_app3/ui/theme.dart';
import 'package:flutter_app3/ui/widgets/button.dart';
import 'package:flutter_app3/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh: mm a')
      .format(DateTime.now().add(const Duration(minutes: 1)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              leading: IconButton(
                onPressed: () async {
                  await _taskController.getTasks();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text(
                'Add Task',
                style: headingStyle.copyWith(
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              ),
              elevation: 0.0,
              backgroundColor: context.theme.backgroundColor,
              centerTitle: true,
              actions: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/person.jpeg'),
                  radius: 18.0,
                ),
                SizedBox(
                  width: 20.0,
                )
              ]),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Column(
              children: [
                InputField(
                  title: 'Title',
                  hint: 'Enter title here',
                  controller: _titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter note here',
                  controller: _noteController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(selectedDate),
                  widget: IconButton(
                    onPressed: () => getDataFromUser(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: startTime,
                        widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: true),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: endTime,
                        widget: IconButton(
                          onPressed: () => getTimeFromUser(isStartTime: false),
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hint: '$_selectedRemind minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        items: remindList
                            .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  '$value',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32.0,
                        elevation: 4,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              _selectedRemind = int.parse(newValue!);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 6.0,
                      )
                    ],
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10.0),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32.0,
                        elevation: 4,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRepeat = newValue!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 6.0,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: titleStyle,
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                children: List.generate(
                                  3,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedColor = index;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                        radius: 12,
                                        child: _selectedColor == index
                                            ? const Icon(Icons.done,
                                                size: 16.0, color: Colors.white)
                                            : Container(),
                                        backgroundColor: index == 0
                                            ? primaryClr
                                            : index == 1
                                                ? pinkClr
                                                : orangeClr,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      MyButton(
                        label: 'Create Task',
                        onTap: () => validateDate(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getDataFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    } else {
      print('It\'s null or something is wrang');
    }
  }

  void getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 1))),
    );
    String formattedTime = pickedTime!.format(context);
    if (isStartTime) {
      setState(() {
        startTime = formattedTime;
      });
    }
    if (!isStartTime) {
      setState(() {
        endTime = formattedTime;
      });
    } else {
      print('time canceled or something is wrang');
    }
  }

  void validateDate() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      await addTaskToDb();
      await _taskController.getTasks();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    } else {
      print(
          '#################### SOMETHING BAD HAPPENED #####################');
    }
  }

  Future<void> addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(selectedDate),
        startTime: startTime,
        endTime: endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      ),
    );
    print('$value');
  }
}
