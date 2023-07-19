import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Model/task_data.dart';
import 'package:task_manager/Sevices/remote_services.dart';
import 'package:task_manager/Widgets/Task_wid.dart';
import 'package:task_manager/Widgets/button_widget.dart';
import 'package:task_manager/screens/add_task.dart';

import 'home_page.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskData> myData=[];
  int myDataLength=0;
  final leftEditIcon=Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.only(bottom: 10),
    color:const Color(0xFF2e3253).withOpacity(0.5),
    child:const Icon(Icons.edit,
            color: Colors.white,
    ),
  );
  final deleteIcon=Container(
    margin: const EdgeInsets.only(bottom: 10),
    color:Colors.redAccent,
    alignment: Alignment.centerRight,
    child:const Icon(Icons.delete,
            color: Colors.white,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height/3.2,
            padding: const EdgeInsets.only(top: 30,left: 5),
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
          Row(

            children: [
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Get.back();
                },
                  child: const Icon(Icons.home,color:Color(0xFF6c8ee3) ,size: 30,)),
              const SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  Get.to(()=>AddTask(),transition: Transition.zoom,duration:const Duration(milliseconds: 500));
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    color: Colors.black
                  ),
                  child: const Icon(Icons.add,color: Colors.white,),
                ),
              ),
              const Spacer(),
              const Icon(Icons.calendar_month_sharp,color:Color(0xFF6c8ee3),),
              const SizedBox(width: 10,),
               Text('${myData.length}',style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF6c8ee3),
              ),),
              const SizedBox(width: 15,)
            ],
          ),
          Flexible(
            child: StreamBuilder<List<TaskData>>(
              stream: RemoteServices().getTasks(cid),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                 if(snapshot.data!=null){
                   myData=snapshot.data!;
                   if(myDataLength!=myData.length){
                     myDataLength=myData.length;
                     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                       setState(() {

                       });
                     });
                   }
                 }
                 if(myData.isEmpty){
                   return const Center(child: Text('No task Added yet',style: TextStyle(fontSize: 30),),);
                 }
                  return ListView.builder(
                  itemCount: myData.length,
                    itemBuilder:(context,index){
                    return Dismissible(
                      background: leftEditIcon,
                      secondaryBackground: deleteIcon,
                      onDismissed: (DismissDirection dir){

                      },
                      confirmDismiss:(DismissDirection dir)async{
                        if(dir==DismissDirection.startToEnd){
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                              barrierColor: Colors.transparent,
                              context: context, builder: (context){
                            return Container(
                              height: 550,
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2e3253).withOpacity(0.4),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context,rootNavigator: true).pop();
                                       Get.to(()=>AddTask(data: myData[index],isViewing: true),transition: Transition.zoom,duration: const Duration(milliseconds: 500));

                                    },
                                      child: const ButtonWidget(color: Color(0xFF202e59), text: 'View', textColor:Colors.white)),
                                  const SizedBox(height: 20,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context,rootNavigator: true).pop();
                                      Get.to(()=>AddTask(data: myData[index],isEditing: true,),transition: Transition.zoom,duration: const Duration(milliseconds: 500));

                                    },
                                      child: const ButtonWidget(color: Color(0xFF202e59), text: 'Edit', textColor:Colors.white)),
                                ],
                              )
                            );
                          });
                          return false;
                        }
                        else{
                          RemoteServices().deleteSingleTask(cid, myData[index].id);
                          return Future.delayed(const Duration(seconds: 1),()=>dir==DismissDirection.endToStart);
                        }


                      },
                      key: ObjectKey(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TaskContainer(text: myData[index].taskName, color: Colors.blueGrey),
                      ),
                    );
                    });
                }
                return const Center(child: CircularProgressIndicator());
              }
            ),
          )
        ],
      ),
    );
  }
}
