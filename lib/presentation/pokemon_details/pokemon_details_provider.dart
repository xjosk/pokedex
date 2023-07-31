import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';
import 'package:pokedex/domain/entities/pokemon_stats.dart';

import '../../domain/entities/pokemon_move.dart';

final pokemonAbout = StateProvider.autoDispose<PokemonAbout?>((ref) => null);
final pokemonStats = StateProvider.autoDispose<PokemonStats?>((ref) => null);
final pokemonMoves =
    StateProvider.autoDispose<List<PokemonMove>>((ref) => []);
