import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_list/infrastructure/navigation/routes.dart';
import 'package:todo_list/infrastructure/theme/text.theme.dart';
import 'package:todo_list/presentation/todo_list/view_todo_list_controller.dart';

import '../../infrastructure/core/base/base_view.dart';

class ViewTodoListPage extends BaseView<ViewTodoListController> {

  @override
  Color pageBackgroundColor() {
    // TODO: implement pageBackgroundColor
    return Colors.white;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create Todo',style: boldTextStyle(fontSize: dimen20,color: Colors.black),),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    controller.createNewTodo();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.redAccent,Colors.orange],begin: Alignment.centerLeft,end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text('Create New',style: regularTextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Obx(() => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child:!controller.isInitialize.value?Center(child: CircularProgressIndicator()): controller.todoList.isNotEmpty?
                  ListView.builder(
                      itemCount: controller.todoList.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                           if(controller.todoList[index].status == 'Incomplete'){
                             controller.updateData(index);
                           }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.redAccent,Colors.orange],begin: Alignment.centerLeft,end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${controller.todoList[index].title}',style: boldTextStyle(fontSize: dimen13,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Text('${controller.todoList[index].description}',style: regularTextStyle(fontSize: dimen11,color: Colors.white),),
                                      SizedBox(height: 5,),
                                      Text('${controller.todoList[index].date}',style: regularTextStyle(fontSize: dimen11,color: Colors.white),)
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              controller.deleteData(controller.todoList[index].id);
                                            },
                                            child: Icon(Icons.delete,color: Colors.white,))
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text(controller.todoList[index].status,style: mediumTextStyle(fontSize: dimen13,color: controller.todoList[index].status == 'Complete'?Colors.greenAccent: Colors.red),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }):Center(child: Text('No Data Found',style: mediumTextStyle(fontSize: dimen16,color: Colors.black),)),
                ),
              ))
            ],
          ),
        ));
  }
}
