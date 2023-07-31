import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class CreatePokemonTeam {
  CreatePokemonTeam(this.repository);

  final PokemonRepository repository;

  Future<void> execute({
    required List<String> pokemonNames,
    required String teamName,
  }) async {
    final pokemonIds = <int>[];
    for (var pokemonName in pokemonNames) {
      final pokemonId = await repository.insertPokemon(pokemonName);
      if (pokemonId == 0) {
        final pokemonId = await repository.getPokemonId(pokemonName);
        pokemonIds.add(pokemonId);
        continue;
      }
      pokemonIds.add(pokemonId);
    }

    final teamId = await repository.insertTeam(
      teamName: teamName,
      userId: repository.getSessionId(),
    );

    for (var pokemonId in pokemonIds) {
      await repository.insertTeams_Pokemon(
        teamId: teamId,
        pokemonId: pokemonId,
      );
    }
  }
}
