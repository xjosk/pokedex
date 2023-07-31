import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';

final offsetProvider = StateProvider((ref) => 0);
final areTeamsBeingCreated = StateProvider((ref) => false);

class PokemonPreviews extends StateNotifier<List<PokemonPreview?>?> {
  PokemonPreviews() : super(const []);

  void replace(List<PokemonPreview?>? pokemonPreviews) {
    state = pokemonPreviews;
  }

  void addAll(List<PokemonPreview?>? pokemonPreviews) {
    state = [...state!, ...pokemonPreviews!];
  }
}

final pokemonPreviews =
    StateNotifierProvider.autoDispose<PokemonPreviews, List<PokemonPreview?>?>(
  (ref) => PokemonPreviews(),
);

class SelectedPokemon extends StateNotifier<List<String>> {
  SelectedPokemon() : super([]);

  void clear() {
    state = [];
  }

  void add(String value) {
    state = [...state, value];
  }

  void remove(String value) {
    state = state.where((e) => e != value).toList();
  }
}

final selectedPokemon =
    StateNotifierProvider.autoDispose<SelectedPokemon, List<String>>(
  (ref) => SelectedPokemon(),
);
