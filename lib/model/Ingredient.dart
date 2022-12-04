class Ingredient {
  final String id;
  final String title;
  final int amount;
  final String img_url;
  final double fat;
  final double sugar;
  final double carbs;
  int count = 0;

  Ingredient(
      {required this.id,
      required this.title,
      required this.img_url,
      required this.fat,
      required this.sugar,
      required this.carbs,
      this.amount = 0,
      this.count = 1});

   static List<Ingredient> ingredients = [
    Ingredient(
        id: '1',
        title: 'apple',
        fat: 0,
        sugar: 19,
        carbs: 25,
        img_url:
            'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand'),
    Ingredient(
        id: '2',
        title: 'banana',
        fat: 0,
        sugar: 15,
        carbs: 28,
        img_url: 'https://i.imgur.com/Aos9oUU.jpg'),
  ];
}
