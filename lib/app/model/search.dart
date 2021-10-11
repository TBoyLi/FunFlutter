class SearchHotKey {
  int id;
  String link;
  String name;
  int order;
  int visible;

  SearchHotKey.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        link = map['link'],
        name = map['name'],
        order = map['order'],
        visible = map['visible'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "order": order,
        "visible": visible,
      };
}
