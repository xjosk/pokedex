import 'package:pokedex/domain/entities/pokemon_stats.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonStats {
  final PokemonRepository repository;

  const GetPokemonStats(this.repository);

  Future<PokemonStats> call({
    required String pokemonName,
  }) async {
    return repository.getPokemonStats(pokemonName);
  }
}
