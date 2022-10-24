class Ingredient {
  final String id;
  final String title;
  final int amount;
  final String img_url;

  const Ingredient({
    required this.id,
    required this.title,
    required this.img_url,
    this.amount = 0,

  });

  static const List<Ingredient> ingredients = [
    Ingredient(id: '1', title: 'apple', img_url: 'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand'),
    Ingredient(id: '2', title: 'banana', img_url: 'https://i.imgur.com/Aos9oUU.jpg'),
  ];
}
