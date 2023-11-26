import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_list/infrastructure/theme/text.theme.dart';

import '../../infrastructure/core/base/base_view.dart';
import 'create_todo_controller.dart';
import 'package:intl/intl.dart';

class CreateTodoPage extends BaseView<CreateTodoController> {

  @override
  Color pageBackgroundColor() {
    return Colors.white;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
          children: [
        Align(
            alignment: Alignment.topLeft,
          child: IconButton(icon: Icon(Icons.close),onPressed: (){
            Get.back();
          }),
        ),
          Text('Create Todo List',style: boldTextStyle(fontSize: dimen20,color: Colors.black),),
           SizedBox(height: 30,),
           Container(
         height: 50,
         alignment: Alignment.center,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15),
             border: Border.all(color: Colors.grey)
         ),
         padding: EdgeInsets.only(left: 10),
         child: TextFormField(
             controller: controller.titleController,
             maxLength: 30,
             decoration: InputDecoration(hintText: 'Enter title',border: InputBorder.none,counterText: ''),
            onChanged: (val){
              controller.onChange(val);
            },
            style: TextStyle(color: Colors.black),

         ),
           ),
        SizedBox(height: 20,),
        Container(
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey)
          ),
          padding: EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: controller.descriptionController,
            maxLength: 100,
            maxLines: 3,
            decoration: InputDecoration(counterText: '',border: InputBorder.none,hintText: 'Enter description'),
            onChanged: (val){
              controller.onChange(val);
            },
            style: TextStyle(color: Colors.black),

          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey)
          ),
          padding: EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: controller.datePickerController,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () async {
                  var date  = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                    );
               controller.datePickerController.text  = DateFormat('MMM dd yyyy').format(date);
                 controller.onChange(controller.datePickerController.text);
                  },
                  child: Icon(Icons.calendar_month,color: Colors.grey,size: 25.0)),
              hintText: 'Pick date',
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.black),

          ),
        ),
        SizedBox(height: 35,),
        GetBuilder(builder: (CreateTodoController _controller){
          return GestureDetector(
            onTap: (){
              if(_controller.shouldEnable()){
                FocusManager.instance.primaryFocus.unfocus();
                _controller.updateData();
              }
            },
            child: Container(
              height: 50,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: _controller.shouldEnable() != null && _controller.shouldEnable()? [Colors.redAccent,Colors.orange]:[Colors.grey,Colors.grey],begin: Alignment.centerLeft,end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text('Submit',style: mediumTextStyle(fontSize: dimen13,color: Colors.white),),
            ),
          );
        })
          ],
        ),
        ));
  }
}
