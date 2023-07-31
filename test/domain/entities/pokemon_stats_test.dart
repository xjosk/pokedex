import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entities/pokemon_stats.dart';

void main() {
  const expectedSum = 6;

  final pokemonStats = PokemonStats(
    hp: 1,
    attack: 1,
    defense: 1,
    specialAttack: 1,
    specialDefense: 1,
    speed: 1,
  );

  test(
    'should return the total sum of stats',
    () {
      final actual = pokemonStats.total;
      
      expect(actual, expectedSum);
    },
  );
}
