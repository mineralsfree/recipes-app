class Recipe {
  int recipeId;
  String name;
  String instructions;
  List<String> ingrReadable;
  int time;
  int serves;
  String category;
  double energy;
  double fat;
  double protein;
  double salt;
  double saturates;
  double sugars;
  String fatLight;
  String saltLight;
  String saturatesLight;
  String sugarsLight;
  String img_url;
  bool in_history;
  bool in_favorites;

  Recipe(
      {required this.img_url,
      required this.recipeId,
      required this.name,
      required this.instructions,
      required this.ingrReadable,
      required this.time,
      required this.serves,
      required this.category,
      required this.energy,
      required this.fat,
      required this.protein,
      required this.salt,
      required this.saturates,
      required this.sugars,
      required this.fatLight,
      required this.saltLight,
      required this.saturatesLight,
      required this.sugarsLight,
      required this.in_history,
      required this.in_favorites});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      in_history: json['in_history'] == 0 ? false : true,
      in_favorites: json['in_favorites'] == 0 ? false : true,
      img_url: json['img_url'] ?? 'http://notfound.com',
      recipeId: json['recipe_id'] as int,
      name: json['name'] as String,
      instructions: json['instructions'] as String,
      ingrReadable: List.from(json['ingr_readable']),
      time: json['time'] as int,
      serves: json['serves'] as int,
      category: json['category'] as String,
      energy: json['energy'] as double,
      fat: json['fat'] as double,
      protein: json['protein'] as double,
      salt: json['salt'] as double,
      saturates: json['saturates'] as double,
      sugars: json['sugars'] as double,
      fatLight: json['fat_light'] as String,
      saltLight: json['salt_light'] as String,
      saturatesLight: json['saturates_light'] as String,
      sugarsLight: json['sugars_light'] as String,
    );
  }
}
