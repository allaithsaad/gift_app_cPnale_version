import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? name,
      productsIds,
      shopBackground,
      accountingId,
      phoneNumer,
      storeId,
      storeLatitude,
      storeLongitude,
      notes;
  bool? states;
  GeoPoint? storeLocation;

  StoreModel({
    this.name,
    this.shopBackground,
    this.accountingId,
    this.phoneNumer,
    this.storeId,
    this.storeLocation,
    this.notes,
    this.states,
  });

  StoreModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    shopBackground = map['shopBackground'];
    accountingId = map['accountingId'];
    phoneNumer = map['phoneNumer'];
    storeId = map['storeId'];
    storeLocation = map['storeLocation'];
    notes = map['notes'];
    states = map['states'];
  }

  toJson() {
    return {
      'name': name,
      'shopBackground': shopBackground,
      'accountingId': accountingId,
      'phoneNumer': phoneNumer,
      'storeLocation': storeLocation,
      'notes': notes,
      'states': states,
    };
  }
}
