import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '/screen/UserOrderScreen.dart';
import 'orderController.dart';
import '../models/user_model.dart';

class UsersController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final orderController = Get.find<OrderController>();
  List<UserModel> get userList => _userList;
  static List<UserModel> _userList = [];

  List<UserModel> get searchUserList => _searchUserList;
  static List<UserModel> _searchUserList = [];

  bool getUsersIsloading = false;
  getUsers() async {
    _userList.clear();
    getUsersIsloading = true;
    await _firebaseFirestore
        .collection("Users")
        .orderBy("registrationDate")
        .limit(50)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _userList.add(UserModel.fromJson(element.data()));
        update();
        getUsersIsloading = false;
      });
    });
    getUsersIsloading = false;
    print(_userList[0].name);
  }

  unVerfiy({String? id, bool? verify, bool? blacklist}) async {
    //   try {
    //     await FirebaseFirestore.instance.collection('Users').doc(id).update(
    //         {'verifiedUser': verify, 'blacklist': blacklist}).whenComplete(() {
    //       Get.snackbar("title", "the Opreation Done ");
    //       Get.back();
    //     });
    //   } catch (error) {
    //     print(id);
    //     print(error);
    //     Get.snackbar("error", " this Opration dose not compelet! ");
    //   }
    // }
  }

  searchForUser(String phone) async {
    _searchUserList.clear();
    await _firebaseFirestore
        .collection('Users')
        .where('phoneNumber', isEqualTo: "+967$phone")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          _searchUserList.add(UserModel.fromJson(element.data()));
        });
        orderController.fatchUserOrders(searchUserList[0].userId!);
        Get.to(
          UserOrdersScreen(
            "All Order of User : ${searchUserList[0].name} ",
            searchUserList[0].verifiedUser!,
            searchUserList[0].blacklist!,
            searchUserList[0].userId!,
            searchUserList[0].name!,
            searchUserList[0].birthDay!,
            searchUserList[0].gender!,
          ),
        );
      } else {
        Get.snackbar("message", "user $phone is not exiets");
      }
    });
  }
}
