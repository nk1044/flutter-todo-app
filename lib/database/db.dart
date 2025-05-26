import 'package:hive_flutter/hive_flutter.dart';

// Add this annotation and part directive
part 'db.g.dart'; // This will be generated

@HiveType(typeId: 0)
class TodoItem extends HiveObject {
  @HiveField(0)
  String title;
  
  @HiveField(1)
  String content;
  
  @HiveField(2)
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false, this.content = ''});
}

class TodoManager {
  List<TodoItem> _todoList = [TodoItem(title: "Add new task")];
  final _mybox = Hive.box('todoBox');

  // Load data when TodoManager is initialized
  TodoManager() {
    loadData();
  }

  void loadData() {
    // Get the data with proper type casting
    final data = _mybox.get('todoList');
    if (data != null) {
      _todoList = List<TodoItem>.from(data);
    } else {
      _todoList = [TodoItem(title: "Add new task")];
    }
  }

  void saveData() {
    // Save the todo list 
    _mybox.put('todoList', _todoList);
  }

  /// Returns the entire todo list
  List<TodoItem> getTodoList() {
    return _todoList;
  }

  /// Returns a todo item at a specific index
  TodoItem getItemByIndex(int index) {
    return _todoList[index];
  }

  /// Adds a new todo item
  int addTodo(String title) {
    _todoList.add(TodoItem(title: title.isNotEmpty ? title : "Add new task"));
    saveData();
    return _todoList.length - 1;
  }

  /// Updates a todo item's title or completion status at a given index
  void updateTodo({
    required int index,
    String? title,
    bool? isCompleted,
    String? content,
  }) {
    if (index < 0 || index >= _todoList.length) return;
    if (title != null) _todoList[index].title = title;
    if (isCompleted != null) _todoList[index].isCompleted = isCompleted;
    if (content != null) _todoList[index].content = content;
    saveData();
  }

  /// Deletes a todo item at a given index
  void deleteItem(int index) {
    if (index >= 0 && index < _todoList.length) {
      _todoList.removeAt(index);
    }
    saveData();
  }
  
  void checkboxChange(int index, bool? value) {
    if (index >= 0 && index < _todoList.length) {
      _todoList[index].isCompleted = value ?? false;
    }
    saveData();
  }
}

final todoManager = TodoManager();