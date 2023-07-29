import 'package:pokedex/domain/entities/pokemon_preview.dart';

import '../entities/pokemon_about.dart';
import '../entities/pokemon_move.dart';
import '../entities/pokemon_stats.dart';

abstract class PokemonRepository {
  Future<List<PokemonPreview>> getPokemon(int offset);
  Future<PokemonAbout> getPokemonAbout(String pokemonName);
  Future<PokemonStats> getPokemonStats(String pokemonName);
  Future<List<PokemonMove>> getPokemonMoves(String pokemonName);
}
