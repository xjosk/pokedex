import 'package:pokedex/domain/entities/pokemon_move.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonMoves {
  final PokemonRepository repository;

  const GetPokemonMoves(this.repository);

  Future<List<PokemonMove>> call({
    required String pokemonName,
  }) async {
    return await repository.getPokemonMoves(pokemonName);
  }
}
