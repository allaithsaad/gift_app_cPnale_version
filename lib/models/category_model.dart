class CategoryModel {
  String? imageUrl, name, fcategoryId;
  int? categoryId;
  bool? categoryStatues;

  CategoryModel({
    this.imageUrl,
    this.name,
    this.categoryId,
    this.fcategoryId,
    this.categoryStatues,
  });

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    imageUrl = map['imageUrl'];

    name = map['name'];
    categoryId = map['categoryId'];
    fcategoryId = map['fcategoryId'];
    categoryStatues = map['categoryStatues'];
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'categoryId': categoryId,
      'fcategoryId': fcategoryId,
      'categoryStatues': categoryStatues,
    };
  }
}
