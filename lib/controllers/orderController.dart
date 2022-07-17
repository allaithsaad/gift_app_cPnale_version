import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '/screen/orderScreen.dart';
import '/screen/orderStutsScreen.dart';
import '../models/orderModel.dart';

class OrderController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;

  List<OrderModel> get orderList => _orderlist;
  static List<OrderModel> _orderlist = [];

  List<OrderModel> get allOrderList => _allOrderList;
  static List<OrderModel> _allOrderList = [];

  List<OrderModel> get searchUserOrder => _searchUserOrder;
  static List<OrderModel> _searchUserOrder = [];

  RxBool isLoadingOrderStuts = false.obs;
  fatchOrderStatusPage(int x, String title) async {
    _orderlist.clear();
    try {
      this.isLoadingOrderStuts.value = true;
      await _firebaseFirestore
          .collection("Orders")
          .where('orderState', isEqualTo: x)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _orderlist.add(OrderModel.fromJson(element.data()));
        });
        update();
        Get.to(OrderStutesScreen(title));
      });
      this.isLoadingOrderStuts.value = false;
    } catch (error) {
      this.isLoadingOrderStuts.value = false;
      Get.snackbar('error', error.toString());
      print(error.toString());
    }
  }

  fatchUserOrders(String id) async {
    try {
      _allOrderList.clear();
      this.isLoadingOrderStuts.value = true;
      await _firebaseFirestore
          .collection("Orders")
          .where('userId', isEqualTo: id)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _allOrderList.add(OrderModel.fromJson(element.data()));
        });
        update();
      });
      this.isLoadingOrderStuts.value = false;
    } catch (error) {
      this.isLoadingOrderStuts.value = false;
      Get.snackbar('error', error.toString());
      print(error.toString());
    }
  }

  fatchAllOrder() async {
    _allOrderList.clear();
    try {
      this.isLoadingOrderStuts.value = true;
      await _firebaseFirestore
          .collection("Orders")
          .orderBy('orderDate')
          .limit(100)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _allOrderList.add(OrderModel.fromJson(element.data()));
        });
        update();
      });
      this.isLoadingOrderStuts.value = false;
    } catch (error) {
      this.isLoadingOrderStuts.value = false;
      Get.snackbar('error', error.toString());
      print(error.toString());
    }
  }

  var isLoadingSearchedOrder = false.obs;
  searchForOrder(String orderId) async {
    isLoadingSearchedOrder.value = true;

    print(orderId);
    _searchUserOrder.clear();
    await _firebaseFirestore
        .collection('Orders')
        .where('orderId', isEqualTo: orderId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          _searchUserOrder.add(OrderModel.fromJson(element.data()));
        });
        isLoadingSearchedOrder.value = false;
        Get.to(OrderScreen("order $orderId "));
      } else {
        isLoadingSearchedOrder.value = false;
        Get.snackbar("message", "Order # $orderId dose not exiets");
      }
    });
  }
}
