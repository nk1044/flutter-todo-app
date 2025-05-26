import 'package:flutter/material.dart';
import 'package:todo/database/db.dart';

class TodoPageCard extends StatefulWidget {
  const TodoPageCard({super.key});

  @override
  State<TodoPageCard> createState() => _TodoPageCardState();
}

class _TodoPageCardState extends State<TodoPageCard> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int index;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    index = args['index'];

    final todo = todoManager.getItemByIndex(index);

    titleController = TextEditingController(text: todo.title);
    contentController = TextEditingController(text: todo.content);
  }

  void updatetodo() {
    todoManager.updateTodo(
      index: index,
      title: titleController.text.isNotEmpty
          ? titleController.text
          : "Add new task",
      content: contentController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todo updated')),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Details"),
        backgroundColor: Colors.amber[500],
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save Todo',
            onPressed: updatetodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Text(
              "Content",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: "Write your notes here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
