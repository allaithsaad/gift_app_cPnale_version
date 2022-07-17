import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/CategoryController.dart';
import '/screen/Main_screen.dart';
import '/screen/login.dart';
import '/screen/splashScreen.dart';

import '/constants.dart';
import 'controllers/OffersController.dart';
import 'controllers/admin_controller.dart';
import 'controllers/orderController.dart';
import 'controllers/stroesController.dart';
import 'controllers/users_controller.dart';
import 'controllers/DashboradController.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Web Dashbored',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
      ),
      initialBinding: BindingsBuilder(() => {
            Get.put(OrderController()),
            Get.put(DashboradCtroller()),
            Get.put(StoresController()),
            Get.put(AdminController()),
            Get.put(UsersController()),
            Get.put(OffersController()),
            Get.put(CategoryController()),
          }),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/MainScreen', page: () => MainScreen()),
        GetPage(name: '/loginScreen', page: () => LogInScreen()),
      ],
    );
  }
}
