class UserModel {
  String? id;
  String? fName;
  String? lName;

  UserModel({this.id, this.fName, this.lName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
  }
}