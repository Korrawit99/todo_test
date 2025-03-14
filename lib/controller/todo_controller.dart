import 'package:get/get.dart';
import 'package:test2/controller/auth_controller.dart';
import 'package:test2/models/todo_model.dart';
import 'package:test2/services/storage.dart';


class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    var todos = await storageService.read(
      'todoList',
      authController.user.value?.uid ?? '',
    );
    if (todos != null) {
      todoList.value = List<TodoModel>.from(
        todos.map((x) => TodoModel.fromJson(x)),
      );
    }
  }

  Future<void> addTodo(String title, String subtitle) async {
    TodoModel todo = TodoModel(
      title,
      subtitle,
      false,
      uid: authController.user.value?.uid,
    );
    String docId = await storageService.write('todoList', todo.toJson());
    todo.docId = docId;
    todoList.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    todoList.firstWhere((todo) => todo.docId == todo.docId).title;
    todoList.firstWhere((todo) => todo.docId == todo.docId).subtitle;
    todoList.refresh();
    await storageService.update('todoList', todo.docId ?? '', todo.toJson());
  }

  void toggleTodo(int index) {
    todoList[index].isDone = !todoList[index].isDone;
    todoList.refresh();
    storageService.update('todoList', todoList[index].docId ?? '', {
      'isDone': todoList[index].isDone,
    });
  }

  void deleteTodo(String docId) {
    todoList.removeWhere((todo) => todo.docId == docId);
    storageService.delete('todoList', docId);
  }

  void clearTodo() {
    todoList.clear();
  }
}