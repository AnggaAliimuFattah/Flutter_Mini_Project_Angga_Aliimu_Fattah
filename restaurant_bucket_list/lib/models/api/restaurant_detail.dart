
class RestoDetail {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  RestoDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestoDetail.fromJson(Map<String, dynamic> json) {
    return RestoDetail(
      error: json['error'],
      message: json['message'],
      restaurant: RestaurantDetail.fromJson(json['restaurant']),
    );
  }
}

// Note: Extending or reusing the Restaurant model as needed
class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String? address;
  final List<Category>? categories;
  final Menu? menus;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      address: json['address'],
      categories: json['categories'] != null ? List<Category>.from(json['categories'].map((x) => Category.fromJson(x))) : null,
      menus: json['menus'] != null ? Menu.fromJson(json['menus']) : null,
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }
}

class Menu {
  final List<Category> foods;
  final List<Category> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List<Category>.from(json['foods'].map((x) => Category.fromJson(x))),
      drinks: List<Category>.from(json['drinks'].map((x) => Category.fromJson(x))),
    );
  }
}