import 'package:get/get.dart';
import 'create_todo_controller.dart';

class CreateTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTodoController>(() => CreateTodoController());
  }
}
