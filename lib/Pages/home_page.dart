import 'package:flutter/material.dart';
import 'package:todo/database/db.dart';
import 'package:todo/utils/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> todoList = [];

  @override
  void initState() {
    super.initState();
    todoManager.loadData();
    _refreshTodoList();
  }

  void _refreshTodoList() {
    setState(() {
      todoList = todoManager.getTodoList();
    });
  }
  void handleCheckboxChange(int index, bool? value) {
    // Optional: handle checkbox change
    todoManager.checkboxChange(index, value);
    _refreshTodoList();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todo updated')),
    );
  }

  void handleDelete(int index) {
    // Optional: handle delete action
    todoManager.deleteItem(index);
    _refreshTodoList();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todo deleted')),
    );
  }

  void handleNavigation(int index) async {
    if (index == 0) {
      // Do nothing or navigate to home (already on home)
    } else if (index == 1) {
      int newIndex = todoManager.addTodo("Add new task");

      await Navigator.pushNamed(
        context,
        '/todo',
        arguments: {'index': newIndex},
      );
      _refreshTodoList();
    }
  }

  void handleItemTap(int index) async {
    await Navigator.pushNamed(
      context,
      '/todo',
      arguments: {'index': index},
    );
    _refreshTodoList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[300],
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        backgroundColor: Colors.amber[500],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ListCard(
            index: index,
            title: todoList[index].title,
            ischecked: todoList[index].isCompleted,
            onTap: () => handleItemTap(index),
            onCheckboxChanged: (bool? value) => handleCheckboxChange(index, value),
            onDelete: handleDelete,
          );

        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: handleNavigation,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
        ],
      ),
    );
  }
}
