import 'package:flutter/material.dart';
import '../Models/pokemon.dart';
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
  List<Pokemon> pokemons = []; // Lista de Pokémon carregados
  bool loading = false;        // Indica se há carregamento em andamento
  int offset = 0;              // Controle de paginação
  final int limit = 20;        // Quantidade de Pokémon por requisição

  @override
  void initState() {
    super.initState();
    fetchPokemons(); // Carrega os primeiros Pokémon ao iniciar
  }

  Future<void> fetchPokemons() async {
    setState(() => loading = true); // Ativa indicador de loading
    try {
      final list = await PokeApi.fetchPokemonList(offset, limit); // Busca da API
      setState(() {
        pokemons.addAll(list); // Adiciona novos Pokémon à lista
        offset += limit;       // Atualiza offset para próxima página
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Erro: $e"))); // Exibe erro
      }
    } finally {
      if (mounted) setState(() => loading = false); // Desativa loading
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
              // Navega para a tela de favoritos
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: pokemons.isEmpty && loading
                ? const Center(child: CircularProgressIndicator()) // Loading inicial
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 colunas de cards
                      childAspectRatio: 3 / 4, 
                    ),
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemons[index];
                      return GestureDetector(
                        // Ao tocar no card, navega para detalhes do Pokémon
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(pokemon: pokemon),
                            ),
                          );
                        },
                        child: PokemonCard(pokemon: pokemon), // Card do Pokémon
                      );
                    },
                  ),
          ),
          if (loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(), // Loading durante paginação
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: loading ? null : fetchPokemons, // Botão "Carregar mais"
              child: const Text("Carregar mais"),
            ),
          ),
        ],
      ),
    );
  }
}
