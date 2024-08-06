import "dart:js_util";
import "dart:math";

import "package:flutter/material.dart";
import "package:todoapp/model/taskmodel.dart";

class TaskViewModel extends ChangeNotifier {
  List<Task> tasks = [];

  String? TaskName;

  setTaskName(String? value) {
    TaskName = value;
    print(value.toString());
    notifyListeners();
  }

  final DateCount = TextEditingController();
  final TimeCount = TextEditingController();

  bool get isvalid =>
      TaskName != null &&
      DateCount.text.isNotEmpty &&
      TimeCount.text.isNotEmpty;

  setDate(DateTime? date) {
    if (date == null) {
      return;
    }
    DateTime currentDate = DateTime.now();
    DateTime now =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    int diff = date.difference(now).inDays;

    if (diff == 0) {
      DateCount.text = "Today";
    } else if (diff == 1) {
      DateCount.text = "Tommorow";
    } else {
      DateCount.text = "${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
    print(date.toString());
  }

  settime(TimeOfDay? time) {
    print(time.toString());
    if (time == null) {
      return;
    }
    if (time.hour == 0) {
      TimeCount.text = "12:${time.minute} AM";
    } else if (time.hour < 12) {
      TimeCount.text = "${time.hour}:${time.minute} AM";
    } else if (time.hour == 12) {
      TimeCount.text = "${time.hour}:${time.minute} PM";
    } else {
      TimeCount.text = "${(time.hour - 12).toString()}:${time.minute} PM";
    }
    notifyListeners();
  }

  addTask() {
    if (!isvalid) {
      return;
    }
    final task = Task(TaskName!, DateCount.text, TimeCount.text);
    tasks.add(task);
    TimeCount.clear();
    DateCount.clear();
    print(tasks.length.toString());
    notifyListeners();
  }
}
