
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../Service/poke_api.dart';
import '../widgets/pokemon_card.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pokemon> pokemons = [];
  bool loading = false;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    setState(() => loading = true);
    try {
      final list = await PokeApi.fetchPokemonList(offset, 20);
      setState(() {
        pokemons.addAll(list);
        offset += 20;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex Explorer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 4),
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
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
          ),
          if (loading) const CircularProgressIndicator(),
          ElevatedButton(
            onPressed: loading ? null : fetchPokemons,
            child: const Text("Carregar mais"),
          ),
        ],
      ),
    );
  }
}
