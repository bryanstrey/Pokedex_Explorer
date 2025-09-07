import 'package:flutter/material.dart';
import '../Models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon; // Pokémon que será exibido no card
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(pokemon.imageUrl, height: 80), // Mostra sprite do Pokémon
          const SizedBox(height: 8),
          Text(
            pokemon.name.toUpperCase(), // Nome em maiúsculas
            style: const TextStyle(fontWeight: FontWeight.bold), // Destaque
          ),
        ],
      ),
    );
  }
}
