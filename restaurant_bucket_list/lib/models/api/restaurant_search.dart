// search_model.dart


class SearchModel {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurant>.from(json['restaurants'].map((x) => Restaurant.fromJson(x))),
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
      );
}