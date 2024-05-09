class DoctorData {
  String? uId;
  String? userType;
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  String? msg;
  bool? isEmail;
  String? specially;
  String? hospitalName;
  String? clinicAddress;
  String? doctorNationalIdNumber;
  String? doctorNationalIdImage;
  String? doctorPicture;
  String? syndicateCardImage;

  DoctorData({
    this.uId,
    this.userType,
    this.name,
    this.email,
    this.phone,
    this.isEmail,
    this.profileImage,
    this.msg,
    this.specially,
    this.hospitalName,
    this.clinicAddress,
    this.doctorNationalIdNumber,
    this.doctorNationalIdImage,
    this.doctorPicture,
    this.syndicateCardImage,
  });

  DoctorData.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    userType = json?['userType'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    isEmail = json?['isEmail'];
    profileImage = json?['profileImage'];
    msg = json?['msg'];
    specially = json?['specially'];
    hospitalName = json?['hospitalName'];
    clinicAddress = json?['clinicAddress'];
    doctorNationalIdNumber = json?['doctorNationalIdNumber'];
    doctorNationalIdImage = json?['doctorNationalIdImage'];
    doctorPicture = json?['doctorPicture'];
    syndicateCardImage = json?['syndicateCardImage'];
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
      'specially': specially,
      'hospitalName': hospitalName,
      'clinicAddress': clinicAddress,
      'doctorNationalIdNumber': doctorNationalIdNumber,
      'doctorNationalIdImage': doctorNationalIdImage,
      'doctorPicture': doctorPicture,
      'syndicateCardImage': syndicateCardImage,
    };
  }
}
