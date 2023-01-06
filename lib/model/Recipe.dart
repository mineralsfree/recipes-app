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

  Recipe({
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
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['recipe_id'] as int,
      name: json['name'] as String,
      instructions: json['instructions'] as String,
      ingrReadable: json['ingr_readable'].split(',') as List<String>,
      time: json['time'] as int,
      serves: json['serves'] as int,
      category: json['category'] as String,
      energy: json['energy'] as double,
      fat: json['fat'] as double,
      protein: json['protein'] as double,
      salt: json['salt'] as double ,
      saturates: json['saturates'] as double,
      sugars: json['sugars'] as double,
      fatLight: json['fat_light'] as String,
      saltLight: json['salt_light'] as String,
      saturatesLight: json['saturates_light'] as String,
      sugarsLight: json['sugars_light'] as String,
    );
  }
}
