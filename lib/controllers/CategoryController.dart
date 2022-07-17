import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import '/models/category_model.dart';

class CategoryController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  RxBool upLoadingCategory = false.obs;
  static List<CategoryModel> get categorylist => _categorylist;
  static List<CategoryModel> _categorylist = [];
  RxBool isLoadingCategory = false.obs;
  getCategory() {
    isLoadingCategory.value = true;
    _categorylist.clear();
    _firebaseFirestore
        .collection('Category')
        .orderBy("categoryId")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _categorylist.add(CategoryModel.fromJson(element.data()));
        isLoadingCategory.value = false;
      });
      update();
    });
  }
}
