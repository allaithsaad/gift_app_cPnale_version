class AdminModel {
  String? adminId, phoneNumber, name, notes;
  bool? gender;
  int? permissionlevel;

  AdminModel({
    this.adminId,
    this.phoneNumber,
    this.name,
    this.gender,
    this.notes,
    this.permissionlevel,
  });

  AdminModel.fromJson(Map<dynamic, dynamic> map) {
    adminId = map['adminId'];
    phoneNumber = map['phoneNumber'];
    name = map['name'];
    gender = map['gender'];
    notes = map['notes'];
    permissionlevel = map['permissionlevel'];
  }

  toJson() {
    return {
      'adminId': adminId,
      'phoneNumber': phoneNumber,
      'name': name,
      'gender': gender,
      'notes': notes,
      'permissionlevel': permissionlevel,
    };
  }
}
