import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_team.dart';

final isPokemonBeingRetrieved = StateProvider((ref) => false);

class PokemonTeamProvider extends StateNotifier<List<PokemonTeam>?> {
  PokemonTeamProvider() : super(null);

  void replace(List<PokemonTeam>? pokemonTeam) {
    state = pokemonTeam;
  }
  
}

final pokemonTeamsProvider =
    StateNotifierProvider.autoDispose<PokemonTeamProvider, List<PokemonTeam>?>(
  (ref) => PokemonTeamProvider(),
);