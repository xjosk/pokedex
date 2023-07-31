import 'package:pokedex/domain/entities/pokemon_team.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonTeams {
  GetPokemonTeams(this.repository);

  final PokemonRepository repository;

  Future<List<PokemonTeam>> call() async {
    final userId = repository.getSessionId();
    final pokemonTeamsMap = await repository.getTeamsMap(userId);
    final newTeamsMap = pokemonTeamsMap.map((e) => Map.of(e)).toList();

    for (var teamMap in pokemonTeamsMap) {
      final teamId = teamMap['id'] as int;
      final pokemonIds = await repository.getPokemonIdsInTeams(teamId);

      final pokemonNames = <String>[];
      for (var pokemonId in pokemonIds) {
        final pokemonName = await repository.getPokemonName(pokemonId);
        pokemonNames.add(pokemonName);
      }

      newTeamsMap.firstWhere(
              (e) => e['id'] == teamMap['id'])['pokemonNames'] =
          pokemonNames;
    }

    return repository.getTeams(newTeamsMap);
  }
}
