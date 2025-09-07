import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/pokemon.dart';

class PokeApi {
  static const String baseUrl = "https://pokeapi.co/api/v2"; // URL base da API

  // Busca lista de Pokémon com paginação (offset + limit)
  static Future<List<Pokemon>> fetchPokemonList(int offset, int limit) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      // Dispara requisições paralelas para buscar detalhes de cada Pokémon
      final futures = results.map((item) async {
        try {
          return await fetchPokemonDetail(item['url']);
        } catch (e) {
          return null; // Ignora falhas individuais
        }
      }).toList();

      // Aguarda todas finalizarem e remove valores nulos
      final pokemons = await Future.wait(futures);
      return pokemons.whereType<Pokemon>().toList();
    } else {
      throw Exception("Erro ao carregar Pokémon");
    }
  }

  // Busca detalhes de um único Pokémon pela URL
  static Future<Pokemon> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data); // Converte JSON em objeto Pokemon
    } else {
      throw Exception("Erro ao carregar detalhes do Pokémon");
    }
  }
}
