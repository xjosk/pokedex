// ignore_for_file: non_constant_identifier_names

import 'package:pokedex/domain/entities/pokemon_preview.dart';

import '../entities/pokemon_about.dart';
import '../entities/pokemon_move.dart';
import '../entities/pokemon_stats.dart';
import '../entities/pokemon_team.dart';

abstract class PokemonRepository {
  Future<List<String?>>? getPokemonFromUrls(int offset);
  Future<List<PokemonPreview?>> getPokemon(List<String?> pokemonUrls);
  Future<PokemonAbout>? getPokemonAbout({
    required Map<String, dynamic> pokemonAboutSpecies,
    required String pokemonName,
  });
  Future<Map<String, dynamic>>? getPokemonAboutSpecies(String pokemonName);
  Future<PokemonStats> getPokemonStats(String pokemonName);
  Future<List<PokemonMove>> getPokemonMoves(String pokemonName);
  Future<int> insertPokemon(String pokemonName);
  Future<int> insertUser({
    required String username,
    required String password,
  });
  Future<void> removeSessionId();
  Future<void> setSessionId(int userId);
  int getSessionId();
  Future<int> login({
    required String username,
    required String password,
  });
  Future<int> insertTeam({
    required String teamName,
    required int userId,
  });
  Future<void> insertTeams_Pokemon({
    required int teamId,
    required int pokemonId,
  });
  Future<int> getPokemonId(String pokemonName);
  Future<List<Map<String, dynamic>>> getTeamsMap(int userId);
  Future<List<int>> getPokemonIdsInTeams(int teamId);
  Future<String> getPokemonName(int pokemonId);
  List<PokemonTeam> getTeams(List<Map<String, dynamic>> map);
}
