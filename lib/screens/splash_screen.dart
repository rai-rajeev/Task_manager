import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/Login_screen.dart';
import 'package:task_manager/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    getPermissionAndFutureDelay();
  }
  void  getPermissionAndFutureDelay() async {


    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    debugPrint('${snapshot.hasData}');
                    return (snapshot.hasData)? const HomeScreen():const LoginScreen();
                  })

          ));
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Manage Tasks',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Caveat',
                //fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              '\nTaskio',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'IBM Plex Serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


