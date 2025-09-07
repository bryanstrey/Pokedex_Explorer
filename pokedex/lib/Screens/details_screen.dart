import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/pokemon.dart';
import '../Providers/favorites_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon; // Pokémon que será exibido
  const DetailsScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(
              favorites.isFavorite(pokemon) ? Icons.star : Icons.star_border,
            ),
            onPressed: () => favorites.toggleFavorite(pokemon),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // centraliza horizontalmente
            children: [
              Image.network(pokemon.imageUrl, height: 200),
              const SizedBox(height: 16),
              Text("Nº ${pokemon.id}", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text("Tipos: ${pokemon.types.join(", ")}", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text("Altura: ${pokemon.height / 10} m", style: const TextStyle(fontSize: 16)),
              Text("Peso: ${pokemon.weight / 10} kg", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text("Habilidades: ${pokemon.abilities.join(", ")}", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Text(
                "Estatísticas",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...pokemon.stats.entries.map((e) => Text(
                    "${e.key.toUpperCase()}: ${e.value}",
                    style: const TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
