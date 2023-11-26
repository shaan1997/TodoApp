import 'package:get/get.dart';

import '../../presentation/create_todo/create_todo_binding.dart';
import '../../presentation/create_todo/create_todo_page.dart';
import '../../presentation/todo_list/view_todo_list_binding.dart';
import '../../presentation/todo_list/view_todo_list_page.dart';
import 'routes.dart';

class AppPages {
  static List<GetPage> pageList = [
    GetPage(
      name: Routes.createTodo,
      page: () => CreateTodoPage(),
      binding: CreateTodoBinding(),
    ),
    GetPage(
      name: Routes.viewTodo,
      page: () => ViewTodoListPage(),
      binding: ViewTodoListBinding(),
    ),
  ];
}
