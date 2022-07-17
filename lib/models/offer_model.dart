class OfferModel {
  String? imageUrl, name, offerId;

  OfferModel({
    this.imageUrl,
    this.name,
    this.offerId,
  });

  OfferModel.fromJson(Map<dynamic, dynamic> map) {
    imageUrl = map['imageUrl'];

    name = map['name'];
    offerId = map['offerId'];
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'offerId': offerId,
    };
  }
}
