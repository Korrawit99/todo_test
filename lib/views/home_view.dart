import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/models/todo_model.dart';

import '../controller/todo_controller.dart';
import '../widgets/todo_tile.dart';
import 'add_todo_view.dart';
import '../controller/auth_controller.dart'; // Import AuthController

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController =
      Get.find<AuthController>(); // Get instance of AuthController

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              todoController.clearTodo();
              await authController.logout();
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todoList[index];
            return TodoTile(
              todo: todoController.todoList[index],
              onToggle:
                  () =>
                      todoController.toggleTodo( index),
              onDelete: () {
                todoController.deleteTodo(todo.docId ?? '');
                Get.snackbar(
                  'Deleted',
                  'Deleted "${todo.title}"',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTodoView()), // Navigate to AddTodoView
        child: Icon(Icons.add),
      ),
    );
  }
}
