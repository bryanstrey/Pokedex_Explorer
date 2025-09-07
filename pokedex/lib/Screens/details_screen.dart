import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/pokemon.dart';
import '../Providers/favorites_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon; // Pokémon que será exibido
  const DetailsScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    // Acessa o provider de favoritos para interações e estado
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()), // Nome do Pokémon
        actions: [
          IconButton(
            // Mostra estrela cheia ou vazia conforme favorito
            icon: Icon(
              favorites.isFavorite(pokemon) ? Icons.star : Icons.star_border,
            ),
            onPressed: () => favorites.toggleFavorite(pokemon), // Alterna favorito
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, height: 200), // Imagem do Pokémon
            const SizedBox(height: 16),
            Text("Nº ${pokemon.id}", style: const TextStyle(fontSize: 18)), // ID
            const SizedBox(height: 8),
            Text(
              "Tipos: ${pokemon.types.join(", ")}", // Lista de tipos
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
