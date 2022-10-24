class Recipe {
  final String id;
  final String title;
  final String img_url;

  const Recipe({
    required this.id,
    required this.title,
    required this.img_url,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(id: json['id'], title: json['title'], img_url: json['img_url']);
  }
}