class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final image = json['sprites']['front_default'];
    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    return Pokemon(
      id: id,
      name: name,
      imageUrl: image,
      types: types,
    );
  }
}
