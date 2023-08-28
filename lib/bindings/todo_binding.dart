import 'package:get/instance_manager.dart';

import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController());
  }
}