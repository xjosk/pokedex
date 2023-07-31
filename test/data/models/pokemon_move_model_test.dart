import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_move_model.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  final pokemonPreview = PokemonMoveModel(
    name: "razor-wind",
    levelLearnedAt: 0,
  );
  group('fromJson', () {
    test(
      'should return a valid pokemon move model',
      () {
        final Map<String, dynamic> jsonMap = jsonDecode(
          fixture('pokemon_move.json'),
        );

        final result = PokemonMoveModel.fromJson(jsonMap);

        expect(result, pokemonPreview);
      },
    );
  });
}
