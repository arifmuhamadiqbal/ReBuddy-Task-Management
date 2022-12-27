import 'package:calendar_app_task_management/models/task.dart';
import 'package:get/get.dart';
import '../database/db_helper.dart';

class TaskController extends GetxController {

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  // add task to database
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // get all task from database
void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
}

// delete task
void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
}

// update status task
void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
}


}