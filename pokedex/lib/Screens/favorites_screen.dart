import 'package:flutter/material.dart';
import '../Providers/favorites_provider.dart';
import '../Widgets/pokemon_card.dart';
import '../Screens/details_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")),
      body: favorites.isEmpty
          ? const Center(child: Text("Nenhum favorito ainda"))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 4),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pokemon = favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailsScreen(pokemon: pokemon)),
                    );
                  },
                  child: PokemonCard(pokemon: pokemon),
                );
              },
            ),
    );
  }
}
