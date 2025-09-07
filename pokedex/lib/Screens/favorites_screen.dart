import 'package:flutter/material.dart';
import '../Providers/favorites_provider.dart';
import '../Widgets/pokemon_card.dart';
import '../Screens/details_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa a lista de Pokémon favoritos do provider
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")), // Barra de título
      body: favorites.isEmpty
          ? const Center(child: Text("Nenhum favorito ainda")) // Mensagem se vazio
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              // Define grade de cards: 2 colunas e proporção 3:4
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 4),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pokemon = favorites[index];
                return GestureDetector(
                  // Ao tocar no card, navega para a tela de detalhes
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailsScreen(pokemon: pokemon)),
                    );
                  },
                  child: PokemonCard(pokemon: pokemon), // Exibe card do Pokémon
                );
              },
            ),
    );
  }
}
