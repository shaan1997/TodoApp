
import 'package:get/get.dart';
import 'package:todo_list/presentation/todo_list/view_todo_list_controller.dart';

class ViewTodoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewTodoListController>(() => ViewTodoListController());
  }
}
