import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';

void main() {
  const expectedHeight = 70;
  const expectedWeight = 6.9;
  const expectedFemaleGenderRate = 0.125;

  final pokemonAbout = PokemonAbout(
    species: "",
    height: 7,
    weight: 69,
    abilites: const <String>[],
    femaleGenderRate: 1,
    eggGroups: const <String>[],
    eggCycle: 0,
  );

  group('height', () {
    test(
      'should properly convert (7) decimeters to centimeters',
      () {
        final actual = pokemonAbout.height;

        expect(actual, expectedHeight);
      },
    );
  });

  group('weight', () {
    test(
      'should properly convert (69) hectograms to kilograms',
      () {
        final actual = pokemonAbout.weight;

        expect(actual, expectedWeight);
      },
    );
  });

  group('female gender rate', () {
    test(
      'should properly convert (1 in eighths) to percentage ',
      () {
        final actual = pokemonAbout.femaleGenderRate;

        expect(actual, expectedFemaleGenderRate);
      },
    );
  });
}
