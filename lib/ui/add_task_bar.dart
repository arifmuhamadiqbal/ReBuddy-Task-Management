import 'package:calendar_app_task_management/controller/task_controller.dart';
import 'package:calendar_app_task_management/ui/theme.dart';
import 'package:calendar_app_task_management/ui/widgets/button.dart';
import 'package:calendar_app_task_management/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat.Hm().format(DateTime.now().toLocal()).toString();
  String _startTime = DateFormat.Hm().format(DateTime.now().toLocal()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",
              style: subHeadingStyle,),
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
              ),
              MyInputField(
                  title: "Note",
                  hint: "Enter your note",
                controller: _noteController,
              ),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined,
                color: Colors.grey,
                ),
                onPressed: () {
                  _getDateFromUser();
                },
              ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          icon: Icon(Icons.access_time_rounded,
                          color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                        ),
                  )),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          icon: Icon(Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                        ),
                      )),
                ],
              ),
              MyInputField(title: "Remind Me", hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down,
                  color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString()
                      ),
                    );
                  }
                  ).toList(),
                ),
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value!, style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  ).toList(),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "Create Task", onTap: () => _validateDate()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // dibawah ini untuk menaruh function
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 25,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/icon-profile.png"
          ),
        ),
        SizedBox(width: 15,
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2125),
    );
    
    if (_pickerDate!=null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("Cannot null !");
    }
  }

  _getTimeFromUser({ required bool isStartTime }) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled");
    } else if(isStartTime==true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if(isStartTime==false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          // _startTime --> 10:30
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1]),
            ),
        );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: titleStyle,
        ),
        SizedBox(height: 6,),
        Wrap(
          children:
          List<Widget>.generate(
              5,
                  (int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor:
                      index==0 ? bluishClr : index==1 ? Colors.pink : index==2 ? Colors.red : index==3 ? Colors.blue : index==4 ? Colors.brown : bluishClr,
                      child: _selectedColor==index?Icon(Icons.done,
                        color: Colors.white,
                        size: 16,
                      ):Container(),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  _addTaskToDatabase() async {
    int value = await _taskController.addTask(
        task: Task(
          title: _titleController.text,
          note: _noteController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )
    );
    print("My id is " + "$value");
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDatabase();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "Your title or note is empty !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: Icon(Icons.warning_amber_rounded,
        color: Colors.black,),
      );
    }
  }
}
