class CoinRecord {
  int coinCount;
  int date;
  String desc;
  int id;
  int type;
  int userId;
  String userName;

  CoinRecord.fromJson(Map<String, dynamic> map)
      : coinCount = map['coinCount'],
        date = map['date'],
        desc = map['desc'],
        id = map['id'],
        type = map['type'],
        userId = map['userId'],
        userName = map['userName'];

  Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "date": date,
        "desc": desc,
        "id": id,
        "type": type,
        "userId": userId,
        "userName": userName,
      };
}
