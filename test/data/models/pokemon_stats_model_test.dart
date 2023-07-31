import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_stats_model.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final pokemonStats = PokemonStatsModel(
    hp: 45,
    attack: 49,
    defense: 49,
    specialAttack: 65,
    specialDefense: 65,
    speed: 45,
  );
  group('fromJson', () {
    test(
      'should return a valid pokemon stats model',
      () {
        final Map<String, dynamic> jsonMap = jsonDecode(
          fixture('pokemon_stats.json'),
        );

        final result = PokemonStatsModel.fromJson(jsonMap);

        expect(result, pokemonStats);
      },
    );
  });
}
