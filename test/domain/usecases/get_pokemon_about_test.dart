import 'package:mocktail/mocktail.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/usecases/get_pokemon_about.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemonAbout usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonAbout(mockPokemonRepository);
  });

  const pokemonName = 'bulbasur';
  final pokemonAbout = PokemonAbout(
    species: 'a',
    height: 7,
    weight: 89,
    abilites: const <String>[
      'a',
      'a',
    ],
    femaleGenderRate: 1,
    eggGroups: const <String>[
      'a',
      'a',
    ],
    eggCycle: 1,
  );

  test(
    'should get information about a specific pokemon from repository',
    () async {
      when(() => mockPokemonRepository.getPokemonAbout(
          pokemonAboutSpecies: {},
          pokemonName: pokemonName)).thenAnswer((_) async => pokemonAbout);

      final result = await usecase.call(pokemonName: pokemonName);

      expect(result, pokemonAbout);
      verify(() => mockPokemonRepository
          .getPokemonAbout(pokemonAboutSpecies: {}, pokemonName: pokemonName)).called(1);
    },
  );
}
