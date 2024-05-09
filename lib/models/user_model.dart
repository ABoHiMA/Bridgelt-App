class UserData {
  String? uId;
  String? userType;
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  bool? isEmail;

  UserData({
    this.uId,
    this.userType,
    this.name,
    this.email,
    this.phone,
    this.isEmail,
    this.profileImage,
  });

  UserData.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    userType = json?['userType'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    isEmail = json?['isEmail'];
    profileImage = json?['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'userType': userType,
      'name': name,
      'email': email,
      'phone': phone,
      'isEmail': isEmail,
      'profileImage': profileImage,
    };
  }
}
