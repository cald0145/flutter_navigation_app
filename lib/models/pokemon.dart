class Pokemon {
  final String name;
  final int height;
  final int weight;
  final String type;

  Pokemon({
    required this.name,
    required this.height,
    required this.weight,
    required this.type,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'type': type,
    };
  }
}
