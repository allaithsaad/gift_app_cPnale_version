import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboradCtroller extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> requestCount0() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 0)
        .snapshots();
  }

  Stream<QuerySnapshot> requestCount1() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 1)
        .snapshots();
  }

  Stream<QuerySnapshot> requestCount2() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 2)
        .snapshots();
  }

  Stream<QuerySnapshot> requestCount3() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 3)
        .snapshots();
  }

  Stream<QuerySnapshot> requestCount4() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 4)
        .snapshots();
  }

  Stream<QuerySnapshot> requestCount5() {
    return _firebaseFirestore
        .collection('Orders')
        .where('orderState', isEqualTo: 5)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
    requestCount0();
    requestCount1();
    requestCount2();
    requestCount3();
    requestCount4();
    requestCount5();
  }
}
