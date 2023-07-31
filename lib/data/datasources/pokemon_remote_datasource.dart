import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/data/models/pokemon_about_model.dart';
import 'package:pokedex/data/models/pokemon_move_model.dart';
import 'package:pokedex/data/models/pokemon_preview_model.dart';
import 'package:pokedex/data/models/pokemon_stats_model.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';

import '../../domain/entities/pokemon_move.dart';
import '../../domain/entities/pokemon_stats.dart';

abstract class PokemonRemoteDatasource {
  Future<List<String>> getPokemonUrls(int offset);
  Future<PokemonPreview>? getPokemonPreview(String url);
  Future<Map<String, dynamic>> getPokemonAboutSpecies(String pokemonName);
  Future<PokemonAbout> getPokemonAbout(
      {required Map<String, dynamic> pokemonSpecies,
      required String pokemonName});
  Future<PokemonStats> getPokemonStats(String pokemonName);
  Future<List<PokemonMove>> getPokemonMoves(String pokemonName);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  PokemonRemoteDatasourceImpl(this.client);

  final http.Client client;
  final String baseUrl = 'https://pokeapi.co/api/v2/';

  @override
  Future<List<String>> getPokemonUrls(int offset) async {
    final url = Uri.parse('${baseUrl}pokemon-form?limit=12&offset=$offset');

    try {
      final response = await client.get(url);

      final json = jsonDecode(response.body);

      return (json['results'] as List).map<String>((e) => e['url']).toList();
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<PokemonPreview> getPokemonPreview(String url) async {
    final uri = Uri.parse(url);

    try {
      final response = await client.get(uri);

      final json = jsonDecode(response.body);

      return PokemonPreviewModel.fromJson(json);
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<List<PokemonMove>> getPokemonMoves(String pokemonName) async {
    final uri = Uri.parse('${baseUrl}pokemon/$pokemonName');

    try {
      final response = await client.get(uri);

      final json = jsonDecode(response.body);

      return (json['moves'] as List)
          .map((e) => PokemonMoveModel.fromJson(e))
          .toList();
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<Map<String, dynamic>> getPokemonAboutSpecies(
      String pokemonName) async {
    final url = Uri.parse('${baseUrl}pokemon-species/$pokemonName');

    try {
      final response = await client.get(url);

      final json = jsonDecode(response.body);

      return json;
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<PokemonAbout> getPokemonAbout(
      {required Map<String, dynamic> pokemonSpecies,
      required String pokemonName}) async {
    final url = Uri.parse('${baseUrl}pokemon/$pokemonName');

    try {
      final response = await client.get(url);

      final json = jsonDecode(response.body);

      pokemonSpecies.addAll(json);

      return PokemonAboutModel.fromJson(pokemonSpecies);
    } on Exception catch (_) {
      return Future.error(_);
    }
  }

  @override
  Future<PokemonStats> getPokemonStats(String pokemonName) async {
    final url = Uri.parse('${baseUrl}pokemon/$pokemonName');
    try {
      final response = await client.get(url);

      final json = jsonDecode(response.body);

      return PokemonStatsModel.fromJson(json);
    } on Exception catch (_) {
      return Future.error(_);
    }
  }
}
