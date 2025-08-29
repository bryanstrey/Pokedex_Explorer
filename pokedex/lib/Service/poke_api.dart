// lib/services/poke_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/pokemon.dart';

class PokeApi {
  static const String baseUrl = "https://pokeapi.co/api/v2";

  static Future<List<Pokemon>> fetchPokemonList(int offset, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      // dispara todas as requisições em paralelo
      final futures = results.map((item) async {
        try {
          return await fetchPokemonDetail(item['url']);
        } catch (e) {
          // se falhar em 1 Pokémon, apenas ignora e retorna null
          return null;
        }
      }).toList();

      // espera todas finalizarem e remove nulos
      final pokemons = await Future.wait(futures);
      return pokemons.whereType<Pokemon>().toList();
    } else {
      throw Exception("Erro ao carregar Pokémon");
    }
  }

  static Future<Pokemon> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception("Erro ao carregar detalhes do Pokémon");
    }
  }
}
