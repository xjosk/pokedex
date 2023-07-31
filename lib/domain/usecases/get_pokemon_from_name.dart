import 'package:pokedex/core/extensions/string_extension.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetPokemonFromName {
  GetPokemonFromName(this.repository);

  final PokemonRepository repository;

  Future<PokemonPreview> call(String name) async {
    final pokemonPreview = await repository
        .getPokemon(['https://pokeapi.co/api/v2/pokemon-form/${name.toLowerCase()}/']);
    return pokemonPreview.first!;
  }
}
