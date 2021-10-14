class Site {
  String? desc;
  String? icon;
  int? id;
  String? link;
  String? name;
  int? order;
  int? userId;
  int? visible;

  Site({
    this.desc,
    this.icon,
    this.id,
    this.link,
    this.name,
    this.order,
    this.userId,
    this.visible,
  });

  Site.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    userId = json['userId'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    return data;
  }
}
