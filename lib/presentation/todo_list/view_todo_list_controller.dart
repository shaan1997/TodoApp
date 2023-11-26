
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_list/infrastructure/model/todo_model.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/services/database_service.dart';
import '../../infrastructure/utills/snackbar.util.dart';

class ViewTodoListController extends GetxController{
var todoList = <TodoModel>[].obs;
var isInitialize = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    final DatabaseService _databaseService = DatabaseService();
    todoList.value = await _databaseService.getTodoList();
    isInitialize.value = true;
  }

  createNewTodo() async {
   var result = await Get.toNamed(Routes.createTodo);
   if(result !=null && result){
     isInitialize.value = false;
     todoList.clear();
     getData();
   }
  }

  deleteData(id) async {
    final DatabaseService _databaseService = DatabaseService();
    await _databaseService.deleteTodo(id);
    getData();
  }

  updateData(index) async {
    var modelData = TodoModel(id: todoList[index].id,title: todoList[index].title,description: todoList[index].description,date: todoList[index].date,status:todoList[index].status == 'Incomplete'?'Complete':'Incomplete');
    try{
      final DatabaseService _databaseService = DatabaseService();
      await _databaseService.updateTodo(modelData,todoList[index].id);
      await getData();
      SnackBarUtil.showSuccess(message: 'Successfully updated');
    }catch(ex){
      debugPrint('error:$ex');
      SnackBarUtil.showError(message: '${ex}');
    }
  }


}