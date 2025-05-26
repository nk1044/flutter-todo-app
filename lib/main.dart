import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Pages/home_page.dart';
import 'package:todo/Pages/todo.dart';
import 'package:todo/database/db.dart'; // Import your db file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  // Register the TodoItem adapter
  Hive.registerAdapter(TodoItemAdapter());
  
  await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/todo': (context) => const TodoPageCard(),
      },
    );
  }
}