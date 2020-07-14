class Media {
  String id;
  String name;
  String url;
  String thumb;
  String icon;
  String size;

  Media.empty() {
    url = "";
    thumb = "";
    icon = "";
  }

  Media({
    this.id,
    this.name,
    this.url,
    this.thumb,
    this.icon,
    this.size,
  });

  Media.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formated_size'];
    } catch (e) {
      //print(jsonMap);
    }
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formated_size"] = size;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
