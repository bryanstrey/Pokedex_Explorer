// lib/services/poke_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApi {
  static const String baseUrl = "https://pokeapi.co/api/v2";

  static Future<List<Pokemon>> fetchPokemonList(int offset, int limit) async {
    final response =
        await http.get(Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      List<Pokemon> pokemons = [];
      for (var item in results) {
        final detail = await fetchPokemonDetail(item['url']);
        pokemons.add(detail);
      }
      return pokemons;
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
