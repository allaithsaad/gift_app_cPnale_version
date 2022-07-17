import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/admin_controller.dart';
import '/screen/Main_screen.dart';
import '/screen/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final adminController = Get.find<AdminController>();
   String? username;
  @override
  void initState() {
    username = FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser!.uid
        : "5665";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: username != "5665" ? MainScreen() : LogInScreen(),

      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //         if (user == null)
      //           Get.to(LogInScreen());
      //         else
      //           Get.to(MainScreen());
      //       });
      //     }
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text('try anther time there is erorr'),
      //       );
      //     } else {
      //       var currentUser = FirebaseAuth.instance.currentUser;
      //       if (currentUser != null) {
      //         print(currentUser.uid);
      //       }
      //       return LogInScreen();
      //     }
      //   },
      // ),
    );
  }
}
