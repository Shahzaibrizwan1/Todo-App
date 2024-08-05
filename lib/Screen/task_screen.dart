import 'dart:js_interop';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/ViewModel/viewmodelprovider.dart';
import 'package:todoapp/constanst/constant.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
          backgroundColor: primary,
          title: const Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.check,
                  size: 16,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "To Do List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return const TaskWidget();
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: primary,
              height: 1,
              thickness: 1,
            );
          },
          itemCount: 5),
      floatingActionButton: const CustomFab(),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        "Doctor Check up",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "Tommorow 3:31 pm",
        style: TextStyle(color: textBlue),
      ),
    );
  }
}

class CustomFab extends StatelessWidget {
  const CustomFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primary,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return const CustomDialog();
            });
      },
      child: Icon(
        Icons.add,
        size: 39,
        color: Colors.white,
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    final taskProvider = Provider.of<TaskViewModel>(context, listen: false);
    return Dialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: sh * 0.6,
          width: sw * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sw * 0.05, vertical: sh * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text(
                  "New Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )),
                const SizedBox(height: 20),
                const Text(
                  "what has to be done?",
                  style: TextStyle(
                    color: textBlue,
                  ),
                ),
                CustomTextField(
                  hint: "Enter a Task",
                  onChanged: (value) {
                    taskProvider.setTaskName(value);
                  },
                ),
                const SizedBox(height: 60),
                const Text(
                  "Due Date",
                  style: TextStyle(
                    color: textBlue,
                  ),
                ),
                CustomTextField(
                  hint: "Pick a Time",
                  controller: taskProvider.DateCount,
                  readonly: true,
                  icon: Icons.calendar_month_outlined,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1999),
                        lastDate: DateTime(2030));

                    taskProvider.setDate(date);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Pick a Time ",
                  controller: taskProvider.TimeCount,
                  icon: Icons.timer,
                  readonly: true,
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    taskProvider.settime(time);
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () async {
                        await taskProvider.addTask();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(color: primary),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.icon,
      this.onTap,
      this.readonly = false,
      this.onChanged,
      this.controller});
  final String hint;
  final IconData? icon;
  final void Function()? onTap;
  final bool readonly;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      width: double.infinity,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        readOnly: readonly,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          // hintText: "Enter a Task", hintStyle: TextStyle(color: Colors.grey)
          suffixIcon: InkWell(
              onTap: onTap,
              child: Icon(
                icon,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
