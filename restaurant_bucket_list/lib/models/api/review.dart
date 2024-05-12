class Review {
  final String id;
  final String name;
  final String review;
  final String date;

  Review({required this.id, required this.name, required this.review, required this.date});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'review': review,
      'date': date,
    };
  }
}