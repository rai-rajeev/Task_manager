import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Model/Task_data.dart';
import 'package:task_manager/Sevices/remote_services.dart';
import 'package:task_manager/Widgets/button_widget.dart';

import '../Widgets/textfield_widget.dart';
import 'home_page.dart';

class AddTask extends StatelessWidget {
  final bool isEditing ;
  final TaskData? data;
  final bool isViewing;

  AddTask({Key? key, this.isEditing=false, this.data, this.isViewing=false,}) : super(key: key);
  final TextEditingController nameController=TextEditingController();
  final TextEditingController detailController=TextEditingController();
 bool isAssigned=false;


  @override
  Widget build(BuildContext context) {
    if(!isAssigned){
      nameController.text=data?.taskName??'';
      detailController.text=data?.taskDetail??'';
      isAssigned=true;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height/3.2,
            padding: EdgeInsets.only(top: 30,left: 5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:AssetImage('assets/task_background.jpg'),
                )
            ),
            child: InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back,color: Color(0xFF6c8ee3), size: 30,)),

          ),
          Container(
            width: double.maxFinite,

            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                TextFieldWidget(
                  readOnly: isViewing,
                  textController: nameController,
                  hintText: 'Task name',
                  borderRadius: 30,

                ),
                const SizedBox(
                  height: 35,
                ),
                ConstrainedBox(

                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/6),
                  child: TextFieldWidget(
                    readOnly: isViewing,
                    textController: detailController,
                    hintText: 'Task detail',
                    borderRadius: 15,
                    maxlines: null,
                  ),
                ),
                const SizedBox(height: 35,),
                (!isViewing)?InkWell(
                  onTap: () async {
                    if(nameController.text.isEmpty){
                      showDialog(context: context, builder: (context){
                        return  CupertinoAlertDialog(
                          content: const Text('Please Provide name to task !'),
                          actions: [
                            SizedBox(
                              width: 50,
                              child: ElevatedButton(
                                  onPressed: (){
                                Navigator.of(context,rootNavigator: true).pop();
                              }, child: const Text('Ok')),
                            ),

                          ],

                        );
                      });
                    }
                   else  if(detailController.text.isEmpty){
                      showDialog(context: context, builder: (context){
                        return  CupertinoAlertDialog(
                          content: const Text('Please Provide name to details of the task to add !'),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Get.back();
                            }, child: const Text('Ok')),

                          ],

                        );
                      });
                    }
                   else{

                      (!isEditing)?await RemoteServices().setTask(cid, TaskData(id: DateTime.now().microsecondsSinceEpoch.toString(), taskName:nameController.text , taskDetail: detailController.text  , date: DateTime.now().toIso8601String())):
                      await RemoteServices().updateTask(cid, {'taskName':nameController.text,
                                                                'taskDetail':detailController.text}, data!.id);
                     Get.back();
                     nameController.clear();
                     detailController.clear();
                    }
                  },

                    child:  ButtonWidget(color: const Color(0xFF202e59), text: (!isEditing)?'Add':'Done', textColor: Colors.white)):const SizedBox()

              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/6,
          )
        ],
      ),
    );
  }
}
