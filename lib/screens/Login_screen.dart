import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/screens/home_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [

            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child:Image.asset('assets/login_background.jpeg',fit: BoxFit.cover,) ,

            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 550,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 28),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Lottie.asset('assets/signin.json',
                                repeat: true),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Welcome to Taskio\n Assist you in managing task',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (loading)?const CircularProgressIndicator():ElevatedButton.icon(
                                  icon: Image.asset(
                                    'assets/google.jpg',
                                    width: 32,
                                    height: 32,
                                  ),
                                  label: const Text(
                                    'Sign in with Google',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      GoogleSignInAccount? googleUser = await GoogleSignIn()
                                          .signIn();
                                      GoogleSignInAuthentication? googleAuth = await googleUser
                                          ?.authentication;
                                      AuthCredential credential = GoogleAuthProvider
                                          .credential(
                                          accessToken: googleAuth?.accessToken,
                                          idToken: googleAuth?.idToken
                                      );
                                      UserCredential usercreden = await FirebaseAuth
                                          .instance.signInWithCredential(
                                          credential);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                    }on FirebaseAuthException catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text('${e.message}'),
                                              actions: [
                                                Builder(builder: (context) {
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context,
                                                            rootNavigator: true)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'));
                                                })
                                              ],
                                            );
                                          });
                                    } on FirebaseException catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text('${e.message}'),
                                              actions: [
                                                Builder(builder: (context) {
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context,
                                                            rootNavigator: true)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'));
                                                })
                                              ],
                                            );
                                          });
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text('$e'),
                                              actions: [
                                                Builder(builder: (context) {
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context,
                                                            rootNavigator: true)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'));
                                                })
                                              ],
                                            );
                                          });
                                    }



                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                ),

                              ]),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Let\'s Get Started! ->',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}