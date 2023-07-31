import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_preview_model.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final pokemonPreview = PokemonPreviewModel(
    name: "bulbasaur",
    types: const <PokemonType>[
      PokemonType.grass,
      PokemonType.poison,
    ],
    spriteUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
  );
  group('fromJson', () {
    test(
      'should return a valid pokemon preview model',
      () {
        final Map<String, dynamic> jsonMap = jsonDecode(
          fixture('pokemon_preview.json'),
        );

        final result = PokemonPreviewModel.fromJson(jsonMap);

        expect(result, pokemonPreview);
      },
    );
  });
}
