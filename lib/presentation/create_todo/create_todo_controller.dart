import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_list/infrastructure/model/todo_model.dart';

import '../../infrastructure/services/database_service.dart';
import '../../infrastructure/utills/snackbar.util.dart';


class CreateTodoController extends GetxController{

  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController datePickerController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  onChange(value){
    update();
  }

  bool shouldEnable(){
    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && datePickerController.text.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }

  updateData() async {
    var modelData = TodoModel(title: titleController.text,description: descriptionController.text,date: datePickerController.text,status: 'Incomplete');
    try{
      final DatabaseService _databaseService = DatabaseService();
      await _databaseService.insertTodo(modelData);
      Get.back(result: true);
      SnackBarUtil.showSuccess(message: 'Successfully added');
    } catch(ex){
      debugPrint('error:$ex');
      SnackBarUtil.showError(message: '${ex}');
    }

  }


  nextScreen() async {
    // for next screen code
  }


}