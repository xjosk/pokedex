// ignore_for_file: non_constant_identifier_names

import 'package:pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/data/models/pokemon_team_model.dart';
import 'package:pokedex/domain/entities/pokemon_stats.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';
import 'package:pokedex/domain/entities/pokemon_move.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';
import 'package:pokedex/domain/entities/pokemon_team.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required this.pokemonRemoteDatasource,
    required this.pokemonLocalDatasource,
  });

  final PokemonRemoteDatasource pokemonRemoteDatasource;
  final PokemonLocalDatasource pokemonLocalDatasource;

  @override
  Future<List<String?>> getPokemonFromUrls(int offset) async {
    try {
      return await pokemonRemoteDatasource.getPokemonUrls(offset);
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<List<PokemonPreview?>> getPokemon(List<String?> pokemonUrls) async {
    final pokemonPreviewList = <PokemonPreview?>[];

    for (var pokemonUrl in pokemonUrls) {
      try {
        final pokemon =
            await pokemonRemoteDatasource.getPokemonPreview(pokemonUrl!);
        if (pokemon == null) continue;
        pokemonPreviewList.add(pokemon);
      } on Exception catch (_) {
        pokemonPreviewList.add(null);
      }
    }
    return pokemonPreviewList;
  }

  @override
  Future<PokemonAbout> getPokemonAbout({
    required Map<String, dynamic> pokemonAboutSpecies,
    required String pokemonName,
  }) async {
    return await pokemonRemoteDatasource.getPokemonAbout(
      pokemonSpecies: pokemonAboutSpecies,
      pokemonName: pokemonName,
    );
  }

  @override
  Future<Map<String, dynamic>> getPokemonAboutSpecies(
      String pokemonName) async {
    return await pokemonRemoteDatasource.getPokemonAboutSpecies(pokemonName);
  }

  @override
  Future<List<PokemonMove>> getPokemonMoves(String pokemonName) async {
    return await pokemonRemoteDatasource.getPokemonMoves(pokemonName);
  }

  @override
  Future<PokemonStats> getPokemonStats(String pokemonName) async {
    return await pokemonRemoteDatasource.getPokemonStats(pokemonName);
  }

  @override
  int getSessionId() {
    return pokemonLocalDatasource.getSessionId();
  }

  @override
  Future<int> insertPokemon(String pokemonName) async {
    return await pokemonLocalDatasource.insertPokemon(pokemonName);
  }

  @override
  Future<int> insertUser({
    required String username,
    required String password,
  }) async {
    return await pokemonLocalDatasource.insertUser(
      username: username,
      password: password,
    );
  }

  @override
  Future<int> login({
    required String username,
    required String password,
  }) async {
    return await pokemonLocalDatasource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<void> setSessionId(int userId) async {
    await pokemonLocalDatasource.setSessionId(userId);
  }

  @override
  Future<void> removeSessionId() async {
    await pokemonLocalDatasource.removeSessionId();
  }

  @override
  Future<int> insertTeam({
    required String teamName,
    required int userId,
  }) async {
    return await pokemonLocalDatasource.insertTeam(
      teamName: teamName,
      userId: userId,
    );
  }

  @override
  Future<void> insertTeams_Pokemon({
    required int teamId,
    required int pokemonId,
  }) async {
    await pokemonLocalDatasource.insertTeams_Pokemon(
      teamId: teamId,
      pokemonId: pokemonId,
    );
  }

  @override
  Future<int> getPokemonId(
    String pokemonName,
  ) async {
    return await pokemonLocalDatasource.getPokemonId(pokemonName);
  }

  @override
  Future<List<int>> getPokemonIdsInTeams(int teamId) async {
    return await pokemonLocalDatasource.getPokemonIdsInTeams(teamId);
  }

  @override
  Future<String> getPokemonName(int pokemonId) async {
    return await pokemonLocalDatasource.getPokemonName(pokemonId);
  }

  @override
  Future<List<Map<String, dynamic>>> getTeamsMap(int userId) async {
    return await pokemonLocalDatasource.getTeams(userId);
  }

  @override
  List<PokemonTeam> getTeams(List<Map<String, dynamic>> map) {
    return map.map((e) => PokemonTeamModel.fromMap(e)).toList();
  }
}
