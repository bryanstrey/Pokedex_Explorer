
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../providers/favorites_provider.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon;
  const DetailsScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context);

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
        child: Column(
          children: [
            Image.network(pokemon.imageUrl, height: 200),
            Text("Nº ${pokemon.id}"),
            Text("Tipos: ${pokemon.types.join(", ")}"),
          ],
        ),
      ),
    );
  }
}
