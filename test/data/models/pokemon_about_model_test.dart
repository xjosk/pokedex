import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_about_model.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final pokemonPreview = PokemonAboutModel(
    species: 'Seed Pokémon',
    height: 7,
    weight: 69,
    abilites: const <String>[
      'overgrow',
      'chlorophyll',
    ],
    femaleGenderRate: 1,
    eggGroups: const <String>[
      'monster',
      'plant',
    ],
    eggCycle: 20
  );
  group('fromJson', () {
    test(
      'should return a valid pokemon move model',
      () {
        final Map<String, dynamic> jsonMap = jsonDecode(
          fixture('pokemon_about.json'),
        );

        final result = PokemonAboutModel.fromJson(jsonMap);

        expect(result, pokemonPreview);
      },
    );
  });
}
