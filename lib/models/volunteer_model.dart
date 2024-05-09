class VolunteerData {
  String? uId;
  String? userType;
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  String? msg;
  bool? isEmail;
  String? volunteerNationalIdNumber;
  String? volunteerHelp;
  String? volunteerGovernorate;
  String? volunteerCity;
  String? volunteerNationalIdPicture;
  String? volunteerPicture;

  VolunteerData({
    this.uId,
    this.userType,
    this.name,
    this.email,
    this.phone,
    this.isEmail,
    this.profileImage,
    this.msg,
    this.volunteerNationalIdNumber,
    this.volunteerHelp,
    this.volunteerGovernorate,
    this.volunteerCity,
    this.volunteerNationalIdPicture,
    this.volunteerPicture,
  });

  VolunteerData.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    userType = json?['userType'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    isEmail = json?['isEmail'];
    profileImage = json?['profileImage'];
    msg = json?['msg'];
    volunteerNationalIdNumber = json?['volunteerNationalIdNumber'];
    volunteerHelp = json?['volunteerHelp'];
    volunteerGovernorate = json?['volunteerGovernorate'];
    volunteerCity = json?['volunteerCity'];
    volunteerNationalIdPicture = json?['volunteerNationalIdPicture'];
    volunteerPicture = json?['volunteerPicture'];
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
      'msg': msg,
      'volunteerNationalIdNumber': volunteerNationalIdNumber,
      'volunteerHelp': volunteerHelp,
      'volunteerGovernorate': volunteerGovernorate,
      'volunteerCity': volunteerCity,
      'volunteerNationalIdPicture': volunteerNationalIdPicture,
      'volunteerPicture': volunteerPicture,
    };
  }
}
