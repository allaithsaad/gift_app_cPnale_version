import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '/controllers/stroesController.dart';
import '/models/admin_model.dart';
import '/screen/Main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AdminController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;
  RxString adminName = ''.obs;
  RxString currentAdminname = ''.obs;
  RxBool isLoading = false.obs;

  static AdminModel get currentAdmin => _currentAdmin!;
  static AdminModel? _currentAdmin;

  signIn({String? email, String? password}) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
          if (user == null) {
          } else {
            await setSPUser(user.uid).then((value) {});
          }
        });

        var tUser = _auth.currentUser;
        if (tUser != null) {
          print(tUser.uid);
          Get.offAll(MainScreen());
          getCurrentAdminData();
          isLoading.value = false;
        }
      });
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Get.snackbar("error", 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("error", 'Wrong password provided for that user.');
      }
      isLoading.value = false;
    }
  }

  Future<AdminModel?> get getSPUser async {
    try {
      AdminModel adminModel = await _getUserData();
      if (adminModel == null) {
        return null;
      }
      print(adminModel);
      return adminModel;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AdminModel> _getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CACHED_USER_DATA);
    return AdminModel.fromJson(json.decode(value!));
  }

  Future<void> setSPUser(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await _firebaseFirestore
        .collection('Admins')
        .doc(id)
        .get()
        .then((value) async {
      await pref.setString(
          CACHED_USER_DATA, json.encode(AdminModel.fromJson(value.data()!)));
    });
  }

  final storesController = Get.find<StoresController>();
  Future<void> getCurrentAdminData() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _firebaseFirestore
            .collection('Admins')
            .doc(user.uid)
            .get()
            .then((value) {
          currentAdminname.value = value.get('name');
        });
      } else {}
    });
  }

  void deleteSPAdmin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  RxBool connectivityStutes = false.obs;
  void checkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        connectivityStutes.value = true;
      } else {
        connectivityStutes.value = false;
      }
    });
  }
}

//Future<void> setSPUser(String id) async {
//  SharedPreferences pref = await SharedPreferences.getInstance();
//  await _firebaseFirestore.collection('Admins').doc(id)..then((value) async {
//    await pref.setString(
//        CACHED_USER_DATA, json.encode(AdminModel.fromJson(value.data()!)));
//  });
//}
//
//}
