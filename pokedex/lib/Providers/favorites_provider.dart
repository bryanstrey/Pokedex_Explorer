import 'package:flutter/material.dart';
import '../Models/pokemon.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Pokemon> _favorites = [];

  List<Pokemon> get favorites => _favorites;

  void toggleFavorite(Pokemon pokemon) {
    if (_favorites.any((p) => p.id == pokemon.id)) {
      _favorites.removeWhere((p) => p.id == pokemon.id);
    } else {
      _favorites.add(pokemon);
    }
    notifyListeners();
  }

  bool isFavorite(Pokemon pokemon) {
    return _favorites.any((p) => p.id == pokemon.id);
  }
}
