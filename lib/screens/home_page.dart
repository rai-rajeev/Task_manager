import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager/Widgets/button_widget.dart';
import 'package:task_manager/screens/Login_screen.dart';
import 'package:task_manager/screens/Tasks.dart';
import 'package:task_manager/screens/add_task.dart';

String cid='';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    cid=FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final drawerButtonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
    alignment: Alignment.centerLeft,
  );
  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  Drawer(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/task_background.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height:80,
                    ),
                    CircleAvatar(
                      radius: 70,
                      foregroundImage: NetworkImage(user!.photoURL??''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user!.displayName??'abc',
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      user!.email!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 0.8,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      TextButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            Get.to(()=>AddTask(),transition: Transition.zoom,duration: const Duration(milliseconds: 500));
                          },
                          style: drawerButtonStyle,
                          icon: const Icon(Icons.add,size: 25,),
                          label: const Text('Add Task',style: TextStyle(fontSize: 25),)),

                      TextButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            await GoogleSignIn().disconnect();
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),ModalRoute.withName('/'));




                          },
                          style: drawerButtonStyle,
                          icon: const Icon(Icons.logout,size: 25,),
                          label: const Text('Logout',style: TextStyle(fontSize: 25),)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.topStart,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image_1.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            IconButton(onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
            }, icon: const Icon(Icons.menu,size: 30,),color: const Color(0xFF2e3253),),
            const SizedBox(height: 30,),
            RichText(text: const TextSpan(text: 'Hello',
            style: TextStyle(
              color: Color(0xFF202e59),
              fontSize: 60,
              fontWeight: FontWeight.bold

            ),
            children: [
                TextSpan(text: '\nwelcome you to Taskio',
                style: TextStyle(
                    color: Color(0xFF2e3253),
                    fontSize: 20,


                ),)
            ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/2.5,),
            InkWell(
              onTap: (){
                Get.to(()=>AddTask(),transition: Transition.zoom,duration: const Duration(milliseconds: 500));
              },
                child: const ButtonWidget(color: Color(0xFF202e59), text: 'Add Task', textColor: Colors.white)),
            const SizedBox(height: 25,),
            InkWell(
              onTap: (){
                Get.to(()=>const TaskScreen(),transition: Transition.fade,duration: const Duration(seconds: 1));
              },
                child: const ButtonWidget(color: Colors.white, text: 'View All',
                    textColor: Color(0xFF2e3253))),


          ],
        ),
      ),

    );
  }
}
