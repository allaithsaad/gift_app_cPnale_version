class ProductModel {
  String? name;
  List<dynamic>? image;
  String? description, category, storeId, componentId;
  bool? available, favorite, verified;
  int? discount, price, popular, productId;

  ProductModel(
      {this.name,
      this.image,
      this.description,
      this.price,
      this.storeId,
      this.category,
      this.available,
      this.discount,
      this.favorite,
      this.verified,
      this.popular,
      this.componentId,
      this.productId});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    storeId = map['storeId'];
    category = map['category'];
    discount = map['discount'];
    available = map['available'];
    favorite = map['favorite'];
    verified = map['verified'];
    popular = map['popular'];
    componentId = map['componentId'];
    productId = map['productId'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'category': category,
      'discount': discount,
      'available': available,
      'storeId': storeId,
      'favorite': favorite,
      'verified': verified,
      'popular': popular,
      'componentId': componentId,
    };
  }
}
