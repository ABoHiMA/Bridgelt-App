class Cases {
  String? uId;
  String? caseId;
  String? name;
  String? profileImage;
  String? time;
  String? text;
  String? gov;
  String? city;
  String? typeOfDisabiliy;
  bool? isMsg;

  Cases({
    this.uId,
    this.caseId,
    this.name,
    this.profileImage,
    this.time,
    this.text,
    this.gov,
    this.city,
    this.typeOfDisabiliy,
    this.isMsg,
  });

  Cases.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    caseId = json?['caseId'];
    name = json?['name'];
    profileImage = json?['profileImage'];
    time = json?['time'];
    text = json?['text'];
    gov = json?['gov'];
    city = json?['city'];
    typeOfDisabiliy = json?['typeOfDisabiliy'];
    isMsg = json?['isMsg'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'caseId': caseId,
      'name': name,
      'profileImage': profileImage,
      'time': time,
      'text': text,
      'gov': gov,
      'city': city,
      'typeOfDisabiliy': typeOfDisabiliy,
      'isMsg': isMsg,
    };
  }
}
