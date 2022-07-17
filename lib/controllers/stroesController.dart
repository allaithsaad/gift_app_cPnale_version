import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '/models/product_model.dart';
import '../models/store_model.dart';

class StoresController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  RxString notificationType = "Reminder".obs;
  static List<StoreModel> get storeModel => _storeslist;
  static List<StoreModel> _storeslist = [];

  static List<ProductModel> get storeProductsModel => _storeProductsModel;
  static List<ProductModel> _storeProductsModel = [];

  bool getStorsIsloading = false;
  RxBool changeUnverify = false.obs;

  getStores() async {
    _storeslist.clear();
    getStorsIsloading = true;
    await _firebaseFirestore.collection("Store").get().then((value) {
      value.docs.forEach((element) {
        _storeslist.add(StoreModel.fromJson(element.data()));
        getStorsIsloading = false;
      });
      update();
    });
    getStorsIsloading = false;
  }

  bool getStoreProductIsLoading = false;

  getStoreProduct(String id) async {
    getStoreProductIsLoading = true;
    _storeProductsModel.clear();
    await _firebaseFirestore
        .collection("Product")
        .where('storeId', isEqualTo: id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _storeProductsModel.add(ProductModel.fromJson(element.data()));

        getStoreProductIsLoading = false;
      });
      update();
    });
    getStoreProductIsLoading = false;
  }

  List<ProductModel> get unVerifyProducts => _unVerifyProducts;
  static List<ProductModel> _unVerifyProducts = [];
  RxInt unVerifyProductsNumber = 0.obs;

  getUnVerifyProducts() async {
    changeUnverify.value = true;
    _unVerifyProducts.clear();
    await _firebaseFirestore
        .collection("productesNew1")
        .where('verified', isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _unVerifyProducts.add(ProductModel.fromJson(element.data()));
        unVerifyProductsNumber.value = _unVerifyProducts.length;
      });
      changeUnverify.value = false;

      update();
    }).catchError((onError) {
      print(onError);
      changeUnverify.value = false;
    });
  }
}
