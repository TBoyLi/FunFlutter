import 'article.dart';

class NavigationSite {
  List<Article> articles;
  int cid;
  String name;

  NavigationSite.fromJson(Map<String, dynamic> map)
      : articles = [
          ...(map['articles'] as List).map((o) => Article.fromJson(o)!)
        ],
        cid = map['cid'],
        name = map['name'];

  Map<String, dynamic> toJson() => {
        "articles": articles,
        "cid": cid,
        "name": name,
      };
}
