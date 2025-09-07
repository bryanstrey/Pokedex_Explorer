class Pokemon {
  final int id;          
  final String name;    
  final String imageUrl; 
  final List<String> types;
  final int height;       // Altura
  final int weight;       // Peso
  final List<String> abilities; // Habilidades
  final Map<String, int> stats; // Estatísticas como HP, Attack, etc.

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final image = json['sprites']['front_default'];

    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();

    final height = json['height'];
    final weight = json['weight'];

    final abilities = (json['abilities'] as List)
        .map((a) => a['ability']['name'] as String)
        .toList();

    final stats = <String, int>{};
    for (var s in json['stats']) {
      stats[s['stat']['name']] = s['base_stat'];
    }

    return Pokemon(
      id: id,
      name: name,
      imageUrl: image,
      types: types,
      height: height,
      weight: weight,
      abilities: abilities,
      stats: stats,
    );
  }
}
