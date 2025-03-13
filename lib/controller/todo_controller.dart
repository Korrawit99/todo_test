import 'package:get/get.dart';
import 'package:test2/controller/auth_controller.dart';
import 'package:test2/core/constants.dart';
import 'package:test2/services/storage.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs; // รายการงานแบบ Observable
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchTodos(); // ดึงข้อมูลงานที่บันทึกไว้
  }

  Future<void> addTodo(String title) async {
    try {
      String? uid = authController.user.value?.uid;
      if (uid == null) return;

      TodoModel newTodo = TodoModel(uid: uid, title: title);
      String docId = await storageService.write(
        AppKey.todoList,
        newTodo.toJson(),
      );

      newTodo.docId = docId;
      todoList.add(newTodo);
      todoList.refresh();
    } catch (e) {
      print("TodoController.addTodo: $e");
    }
  }

  /// Deletes a todo item at the specified index from the todoList and updates
  /// the storage with the modified list.
  ///
  /// Parameters:
  ///   - index: The index of the todo item to be deleted.

  /// ✅ อัปเดตข้อมูลตาม `docId`
  Future<void> toggleTodo(
    String docId,
    bool isCompleted,
  ) async {
    try {
      TodoModel todo = todoList.firstWhere((e) => e.docId == docId);
      todo.isCompleted = isCompleted;
      await storageService.update(AppKey.todoList, docId, todo.toJson());
      todoList.refresh();
    } catch (e) {
      print('StorageService.update: $e');
    }
  }

  /// ✅ ลบข้อมูลตาม `docId`
  Future<void> deleteTodo(String docId) async {
    try {
      await storageService.delete(AppKey.todoList, docId);
      todoList.removeWhere((e) => e.docId == docId);
      todoList.refresh();
    } catch (e) {
      print('StorageService.delete: $e');
    }
  }

  Future<void> fetchTodos() async {
    var todos = await storageService.read(AppKey.todoList, uid: authController.user.value?.uid);
    todoList.value = todos.map((e) => TodoModel.fromJson(e)).toList();
  }
}