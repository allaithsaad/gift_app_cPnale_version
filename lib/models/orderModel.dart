import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? productName,
      productImage,
      deliveryBoyId,
      orderId,
      numberOfBuyer,
      productId,
      note,
      paymentType,
      deliveryPlaceDiscretion;
  int? totalPrice, orderState, productPrice, deliveryPrice;
  bool? verified, paymentState;
  GeoPoint? delvreyLocation, storelocation;
  DateTime? orderDate, dateOfDelivering;

  OrderModel({
    this.productName,
    this.productImage,
    this.deliveryBoyId,
    this.orderId,
    this.numberOfBuyer,
    this.productId,
    this.note,
    this.paymentType,
    this.deliveryPlaceDiscretion,
    this.totalPrice,
    this.orderState,
    this.productPrice,
    this.deliveryPrice,
    this.verified,
    this.paymentState,
    this.delvreyLocation,
    this.storelocation,
    this.orderDate,
    this.dateOfDelivering,
  });

  OrderModel.fromJson(Map<dynamic, dynamic> map) {
    productName = map['productName'];
    productImage = map['productImage'];
    deliveryBoyId = map['deliveryBoyId'];
    orderId = map['orderId'];
    numberOfBuyer = map['numberOfBuyer'];
    productId = map['productId'];
    note = map['note'];
    paymentType = map['paymentType'];
    deliveryPlaceDiscretion = map['deliveryPlaceDiscretion'];
    totalPrice = map['totalPrice'];
    orderState = map['orderState'];
    productPrice = map['productPrice'];
    deliveryPrice = map['deliveryPrice'];
    verified = map['verified'];
    paymentState = map['paymentState'];
    delvreyLocation = map['delvreyLocation'];
    storelocation = map['storelocation'];
    orderDate = DateTime.fromMicrosecondsSinceEpoch(
        map['orderDate'].microsecondsSinceEpoch);
    dateOfDelivering = DateTime.fromMicrosecondsSinceEpoch(
        map['dateOfDelivering'].microsecondsSinceEpoch);
  }

  toJson() {
    return {
      'productName': productName,
      'productImage': productImage,
      'deliveryBoyId': deliveryBoyId,
      'orderId': orderId,
      'numberOfBuyer': numberOfBuyer,
      'productId': productId,
      'note': note,
      'paymentType': paymentType,
      'deliveryPlaceDiscretion': deliveryPlaceDiscretion,
      'totalPrice': totalPrice,
      'orderState': orderState,
      'productPrice': productPrice,
      'deliveryPrice': deliveryPrice,
      'verified': verified,
      'paymentState': paymentState,
      'delvreyLocation': delvreyLocation,
      'storelocation': storelocation,
      'orderDate': orderDate,
      'dateOfDelivering': dateOfDelivering,
    };
  }
}
