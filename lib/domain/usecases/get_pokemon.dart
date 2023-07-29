import 'package:pokedex/domain/entities/pokemon_preview.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemon {
  final PokemonRepository repository;

  const GetPokemon(this.repository);

  Future<List<PokemonPreview>> call({
    required int offset,
  }) async {
    return await repository.getPokemon(offset);
  }
}
