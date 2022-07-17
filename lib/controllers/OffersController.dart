import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '/models/offer_model.dart';

class OffersController extends GetxController {
  final _firebaseFirestore = FirebaseFirestore.instance;
  RxBool upLoadingOffer = false.obs;
  static List<OfferModel> get offersList => _offerslist;
  static List<OfferModel> _offerslist = [];
  RxBool isLoadingOffers = false.obs;
  getOffers() {
    isLoadingOffers.value = true;
    _offerslist.clear();
    _firebaseFirestore.collection('slideshow').get().then((value) {
      value.docs.forEach((element) {
        _offerslist.add(OfferModel.fromJson(element.data()));
        isLoadingOffers.value = false;
      });
      update();
    });
  }
}
