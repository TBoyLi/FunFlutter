class User {
  bool admin;
  List<dynamic> chapterTops;
  List<dynamic> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String token;
  int type;
  String username;

  User.fromJson(Map<String, dynamic>? map)
      : admin = map!["admin"],
        chapterTops = map["chapterTops"],
        collectIds = map["collectIds"],
        email = map["email"],
        icon = map["icon"],
        id = map["id"],
        nickname = map["nickname"],
        password = map["password"],
        token = map["token"],
        type = map["type"],
        username = map["username"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['chapterTops'] = chapterTops;
    data['collectIds'] = collectIds;
    data['email'] = email;
    data['icon'] = icon;
    data['id'] = id;
    data['nickname'] = nickname;
    data['password'] = password;
    data['token'] = token;
    data['type'] = type;
    data['username'] = username;
    return data;
  }
}
