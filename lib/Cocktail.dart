import 'dart:convert';
//Initializing a class Cocktail with all of its parameters and constructors.

// I used https://app.quicktype.io/ to help me with the Cocktail.dart, because it was my first time pulling data from json,
// I didn't know hot to make constructors in flutter, but learned a long the way.
//Only the getGlassType() is my function.

class Cocktail {
  Cocktail({
    required this.name,
    required this.glass,
    this.category,
    required this.ingredients,
    this.garnish,
    this.preparation,
    required this.image
  });

  String name;
  String glass;
  String? category;
  List<Ingredient> ingredients;
  String? garnish;
  String? preparation;
  String image;

  factory Cocktail.fromRawJson(String str) => Cocktail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
// This is used for the CocktailDetail.dart so that the text is displayed better.
  String getGlassType() {
    switch (glass) {
      case "champagne-flute": return "Champagne flute";
      case "champagne-tulip": return "Champagne tulip";
      case "collins": return "Collins";
      case "highball": return "Highball";
      case "hot-drink": return "Hot drink";
      case "hurricane": return "Hurricane";
      case "margarita": return "Margarita";
      case "martini": return "Martini";
      case "old-fashioned": return "Old fashioned";
      case "shot": return "Shot";
      case "white-wine": return "White wine";

      default: {
        return "";
      }
    }
  }

  factory Cocktail.fromJson(Map<String, dynamic> json) => Cocktail(
    name: json["name"],
    glass: json["glass"],
    category: json["category"] == null ? null : json["category"],
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
    garnish: json["garnish"] == null ? null : json["garnish"],
    preparation: json["preparation"] == null ? null : json["preparation"],
    image: 'images/${json["glass"]}.png'
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "glass": glass,
    "category": category == null ? null : category,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "garnish": garnish == null ? null : garnish,
    "preparation": preparation == null ? null : preparation,
    "image": image
  };
}

class Ingredient {
  Ingredient({
    this.unit,
    this.amount,
    this.ingredient,
    this.label,
    this.special,
  });

  Unit? unit;
  double? amount;
  String? ingredient;
  String? label;
  String? special;

  factory Ingredient.fromRawJson(String str) => Ingredient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    unit: json["unit"] == null ? null : unitValues.map[json["unit"]],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    ingredient: json["ingredient"] == null ? null : json["ingredient"],
    label: json["label"] == null ? null : json["label"],
    special: json["special"] == null ? null : json["special"],
  );

  Map<String, dynamic> toJson() => {
    "unit": unit == null ? null : unitValues.reverse?[unit],
    "amount": amount == null ? null : amount,
    "ingredient": ingredient == null ? null : ingredient,
    "label": label == null ? null : label,
    "special": special == null ? null : special,
  };
}

enum Unit { CL }

final unitValues = EnumValues({
  "cl": Unit.CL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
