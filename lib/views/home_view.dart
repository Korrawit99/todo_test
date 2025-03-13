import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/models/todo_model.dart';
import 'package:test2/widgets/snackbar.dart';
import '../controller/todo_controller.dart';
import '../widgets/todo_tile.dart';
import 'add_todo_view.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
   HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List'), backgroundColor: Colors.green),
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            TodoModel todo = todoController.todoList[index];
            return TodoTile(
              todo: todoController.todoList[index],
              onToggle: () => todoController.toggleTodo(
                todo.docId,
                !todo.isCompleted,
              ),
              onDelete: () {
                todoController.deleteTodo(todo.docId);
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
        onPressed: () => Get.to(() => AddTodoView()), // ไปหน้าเพิ่มรายการ
        child: Icon(Icons.add),
      ),
    );
  }
}