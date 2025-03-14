import 'package:test2/controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test2/models/todo_model.dart';

class AddTodoView extends StatefulWidget {
  AddTodoView({super.key, this.todo});
  TodoModel? todo;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController todoController = Get.put(TodoController());

  final titleController = TextEditingController();

  final subtitleController = TextEditingController();

@override
void initState() {
  super.initState();
  if (widget.todo != null) {
    titleController.text = widget.todo!.title;
    subtitleController.text = widget.todo!.subtitle;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มรายการ"), backgroundColor: Colors.green),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
        child: Column(
          children: [
            Text("ชื่อรายการ", style: TextStyle(fontSize: 20)),
            TextField(controller: titleController),
            SizedBox(height: 20),
            Text("รายละเอียด", style: TextStyle(fontSize: 20)),
            TextField(controller: subtitleController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;
                todoController.addTodo(
                  titleController.text,
                  subtitleController.text
                );
                Get.back();
                Get.snackbar(
                   "แจ้งเตือน",
                  "บันทึกเรียบร้อย",
                  colorText: Colors.white,
                  backgroundColor: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                  );
              },
              child: Text("บันทึก"),
            ),
          ],
        ),
      ),
    );
  }
}