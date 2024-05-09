class SpecialNeedData {
  String? uId;
  String? userType;
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  String? msg;
  bool? isEmail;
  String? specialNeedNationalIdNumber;
  String? typeOfDisabiliy;
  String? specialNeedGovernorate;
  String? specialNeedCity;
  String? specialNeedNationalIdPicture;
  String? specialNeedPicture;
  String? disablityCard;
  String? companionName;
  String? companionEmail;
  String? companionNationalIdNumber;
  String? companionNationalIdPicture;
  String? companionPicture;

  SpecialNeedData({
    this.uId,
    this.userType,
    this.name,
    this.email,
    this.phone,
    this.isEmail,
    this.profileImage,
    this.msg,
    this.specialNeedNationalIdNumber,
    this.typeOfDisabiliy,
    this.specialNeedGovernorate,
    this.specialNeedCity,
    this.specialNeedNationalIdPicture,
    this.specialNeedPicture,
    this.disablityCard,
    this.companionName,
    this.companionEmail,
    this.companionNationalIdNumber,
    this.companionNationalIdPicture,
    this.companionPicture,
  });

  SpecialNeedData.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    userType = json?['userType'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    isEmail = json?['isEmail'];
    profileImage = json?['profileImage'];
    msg = json?['msg'];
    specialNeedNationalIdNumber = json?['nationalIdNumber'];
    typeOfDisabiliy = json?['typeOfDisabiliy'];
    specialNeedGovernorate = json?['specialNeedGovernorate'];
    specialNeedCity = json?['specialNeedCity'];
    specialNeedNationalIdPicture = json?['specialNeedNationalIdPicture'];
    specialNeedPicture = json?['specialNeedPicture'];
    disablityCard = json?['disablityCard'];
    companionName = json?['companionName'];
    companionEmail = json?['companionEmail'];
    companionNationalIdNumber = json?['companionNationalIdNumber'];
    companionNationalIdPicture = json?['companionNationalIdPicture'];
    companionPicture = json?['companionPicture'];
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
      'specialNeedNationalIdNumber': specialNeedNationalIdNumber,
      'typeOfDisabiliy': typeOfDisabiliy,
      'specialNeedGovernorate': specialNeedGovernorate,
      'specialNeedCity': specialNeedCity,
      'specialNeedNationalIdPicture': specialNeedNationalIdPicture,
      'specialNeedPicture': specialNeedPicture,
      'disablityCard': disablityCard,
      'companionName': companionName,
      'companionEmail': companionEmail,
      'companionNationalIdNumber': companionNationalIdNumber,
      'companionNationalIdPicture': companionNationalIdPicture,
      'companionPicture': companionPicture,
    };
  }
}
