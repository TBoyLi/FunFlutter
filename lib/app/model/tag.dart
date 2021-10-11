class Tag {
  String name;
  String url;

  Tag.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        url = map['url'];

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
