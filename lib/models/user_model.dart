class UserModel {
  String? userId, phoneNumber, name, notes, birthDay;
  bool? available, blacklist, gender, verifiedUser;

  UserModel({
    this.userId,
    this.phoneNumber,
    this.name,
    this.birthDay,
    this.gender,
    this.blacklist,
    this.notes,
    this.verifiedUser,
  });

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    phoneNumber = map['phoneNumber'];
    name = map['name'];
    birthDay = map['birthDay'];
    gender = map['gender'];
    blacklist = map['blacklist'];
    notes = map['notes'];
    verifiedUser = map['verifiedUser'];
  }

  toJson() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'name': name,
      'birthDay': birthDay,
      'gender': gender,
      'blacklist': blacklist,
      'notes': notes,
      'verifiedUser': verifiedUser,
    };
  }
}
