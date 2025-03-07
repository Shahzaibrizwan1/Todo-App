import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Screen/task_screen.dart';
import 'package:todoapp/ViewModel/viewmodelprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: TaskScreen()),
    );
  }
}
