class Category {
  int id;
  String name;
  String slug;
  String image;

  Category.empty();

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  Category.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        slug = jsonMap['slug'],
        image = jsonMap['media'][0]['url'];
}
