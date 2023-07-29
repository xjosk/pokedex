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
  const pokemonAbout = PokemonAbout(
    species: 'a',
    height: 'a',
    weight: 'a',
    abilites: <String>[
      'a',
      'a',
    ],
    gender: 'a',
    eggGroup: 'a',
    eggCycle: 'a',
  );

  test(
    'should get information about a specific pokemon',
    () async {
      when(() => mockPokemonRepository.getPokemonAbout(any()))
          .thenAnswer((_) async => pokemonAbout);

      final result = await usecase.call(pokemonName: pokemonName);

      expect(result, pokemonAbout);
      verify(() => mockPokemonRepository.getPokemonAbout(pokemonName));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
