class Sessions {
  String? uId;
  String? sessionId;
  String? name;
  String? profileImage;
  String? time;
  String? text;
  String? link;
  String? specially;

  Sessions({
    this.uId,
    this.sessionId,
    this.name,
    this.profileImage,
    this.time,
    this.text,
    this.link,
    this.specially,
  });

  Sessions.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    sessionId = json?['sessionId'];
    name = json?['name'];
    profileImage = json?['profileImage'];
    time = json?['time'];
    text = json?['text'];
    link = json?['link'];
    specially = json?['specially'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'sessionId': sessionId,
      'name': name,
      'profileImage': profileImage,
      'time': time,
      'text': text,
      'link': link,
      'specially': specially,
    };
  }
}
