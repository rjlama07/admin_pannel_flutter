class ProducerModel {
  String name;
  String rating;
  String activeSince;
  String profileUrl;
  String averageDeliveryTime;
  String genre;
  Map<String, Map<String, dynamic>> package;

  ProducerModel(
      {required this.name,
      required this.rating,
      required this.activeSince,
      required this.profileUrl,
      required this.averageDeliveryTime,
      required this.genre,
      required this.package});

  // Convert ProducerModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'activeSince': activeSince,
      'profileUrl': profileUrl,
      'averageDeliveryTime': averageDeliveryTime,
      'genre': genre,
      'package': package
    };
  }

  // Create ProducerModel instance from JSON
  factory ProducerModel.fromJson(Map<String, dynamic> json) {
    return ProducerModel(
        name: json['name'],
        rating: json['rating'],
        activeSince: json['activeSince'],
        profileUrl: json['profileUrl'],
        averageDeliveryTime: json['averageDeliveryTime'],
        genre: json['genre'],
        package: json["package"]);
  }
}

class Package {
  String version;
  String revision;
  String price;

  Package({required this.price, required this.revision, required this.version});

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'revision': revision,
      'version': version,
    };
  }
}
