import 'package:pokedex/domain/entities/pokemon_about.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonAbout {
  final PokemonRepository repository;

  const GetPokemonAbout(this.repository);

  Future<PokemonAbout> call({
    required String pokemonName,
  }) async {
    return repository.getPokemonAbout(pokemonName);
  }
}
