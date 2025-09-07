import 'package:flutter/material.dart';
import '../Models/pokemon.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Pokemon> _favorites = [];

  // Getter público para acessar os favoritos
  List<Pokemon> get favorites => _favorites;

  // Adiciona ou remove um Pokémon dos favoritos
  void toggleFavorite(Pokemon pokemon) {
    if (_favorites.any((p) => p.id == pokemon.id)) {
      _favorites.removeWhere((p) => p.id == pokemon.id); // Remove se já estiver
    } else {
      _favorites.add(pokemon); // Adiciona se não estiver
    }
    notifyListeners(); // Notifica a UI sobre mudanças
  }

  // Verifica se um Pokémon está nos favoritos
  bool isFavorite(Pokemon pokemon) {
    return _favorites.any((p) => p.id == pokemon.id);
  }
}
