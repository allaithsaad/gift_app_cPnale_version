import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/controllers/admin_controller.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    final adminController = Get.find<AdminController>();
    email.text = 'work.laith@gmail.com';
    password.text = '775152516';
    return Scaffold(
      body: Center(
        child: Obx(
          () => adminController.isLoading.value
              ? SpinKitCubeGrid(
                  color: Colors.red,
                  size: 50.0,
                )
              : Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.6,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Login Screen ',
                              style: GoogleFonts.heebo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  letterSpacing: 2),
                            ),
                          ),
                          TextField(
                            controller: email,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(color: Colors.deepPurple),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 1.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.deepPurple)),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.deepPurple,
                              ),
                              labelText: "email",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: password,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(color: Colors.deepPurple),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 1.0),
                              ),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.deepPurple)),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.deepPurple,
                              ),
                              labelText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                adminController.signIn(
                                    email: email.text, password: password.text);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.black),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}




// enum Gender {
//   Email,
//   password,
// }

// class LogInScreen extends StatefulWidget {
//   @override
//   State<LogInScreen> createState() => _LogInScreenState();
// }

// class _LogInScreenState extends State<LogInScreen> {
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final adminController = Get.find<AdminController>();

//   Color enabled = const Color(0xFF827F8A);
//   Color enabledtxt = Colors.white;
//   Color deaible = Colors.grey;
//   Color backgroundColor = const Color(0xFF1F1A30);
//   bool ispasswordev = true;
//   Gender? selected;

//   @override
//   Widget build(BuildContext context) {
//     var we = MediaQuery.of(context).size.width * 0.5;
//     var he = MediaQuery.of(context).size.height * 0.65;
//     return Scaffold(
//         backgroundColor: const Color(0xFF5E3DA0),
//         body: Center(
//           child: SingleChildScrollView(
//             child: SizedBox(
//               width: we,
//               height: he,
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Card(
//                     color: Color(0xFFEEA5E4),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           margin: const EdgeInsets.only(right: 230.0),
//                           child: Text(
//                             "Login",
//                             style: GoogleFonts.heebo(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 35,
//                                 letterSpacing: 2),
//                           ),
//                         ),
//                         SizedBox(
//                           height: he * 0.01,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(right: 150.0),
//                           child: Text(
//                             "Please sing in to continue",
//                             style: GoogleFonts.heebo(
//                                 color: Colors.grey, letterSpacing: 0.5),
//                           ),
//                         ),
//                         SizedBox(
//                           height: he * 0.04,
//                         ),
//                         Container(
//                           width: we * 0.9,
//                           height: he * 0.2,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: selected == Gender.Email
//                                 ? enabled
//                                 : backgroundColor,
//                           ),
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             onTap: () {
//                               setState(() {
//                                 selected = Gender.Email;
//                               });
//                             },
//                             controller: email,
//                             decoration: InputDecoration(
//                               enabledBorder: InputBorder.none,
//                               border: InputBorder.none,
//                               prefixIcon: Icon(
//                                 Icons.email_outlined,
//                                 color: selected == Gender.Email
//                                     ? enabledtxt
//                                     : deaible,
//                               ),
//                               hintText: 'Email',
//                               hintStyle: TextStyle(
//                                 color: selected == Gender.Email
//                                     ? enabledtxt
//                                     : deaible,
//                               ),
//                             ),
//                             style: TextStyle(
//                                 color: selected == Gender.Email
//                                     ? enabledtxt
//                                     : deaible,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         SizedBox(
//                           height: he * 0.02,
//                         ),
//                         Container(
//                           width: we * 0.9,
//                           height: he * 0.2,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                               color: selected == Gender.password
//                                   ? enabled
//                                   : backgroundColor),
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             controller: password,
//                             onTap: () {
//                               setState(() {
//                                 selected = Gender.password;
//                               });
//                             },
//                             decoration: InputDecoration(
//                                 enabledBorder: InputBorder.none,
//                                 border: InputBorder.none,
//                                 prefixIcon: Icon(
//                                   Icons.lock_open_outlined,
//                                   color: selected == Gender.password
//                                       ? enabledtxt
//                                       : deaible,
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: ispasswordev
//                                       ? Icon(
//                                           Icons.visibility_off,
//                                           color: selected == Gender.password
//                                               ? enabledtxt
//                                               : deaible,
//                                         )
//                                       : Icon(
//                                           Icons.visibility,
//                                           color: selected == Gender.password
//                                               ? enabledtxt
//                                               : deaible,
//                                         ),
//                                   onPressed: () => setState(
//                                       () => ispasswordev = !ispasswordev),
//                                 ),
//                                 hintText: 'Password',
//                                 hintStyle: TextStyle(
//                                     color: selected == Gender.password
//                                         ? enabledtxt
//                                         : deaible)),
//                             obscureText: ispasswordev,
//                             style: TextStyle(
//                                 color: selected == Gender.password
//                                     ? enabledtxt
//                                     : deaible,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         SizedBox(
//                           height: he * 0.02,
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               adminController.signIn(
//                                   email: email.text, password: password.text);

//                               print(email);
//                               print(password);
//                             },
//                             child: Text(
//                               "Login",
//                               style: GoogleFonts.heebo(
//                                 color: Colors.black,
//                                 letterSpacing: 0.5,
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             style: TextButton.styleFrom(
//                                 backgroundColor: const Color(0xFF0DF5E4),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15.0, horizontal: 80),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(30.0)))),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
