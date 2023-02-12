class ProfileModel {
  bool? status;
  DataProfileModel? dataProfileModel;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    dataProfileModel = DataProfileModel.fromJson(json['data']);
  }
}

class DataProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic points;
  dynamic credit;

  DataProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = ['credit'];
  }
}
