import 'package:mocktail/mocktail.dart';
import 'package:pokedex/domain/entities/pokemon_stats.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/usecases/get_pokemon_stats.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemonStats usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonStats(mockPokemonRepository);
  });

  const pokemonName = 'bulbasur';
  final pokemonStats = PokemonStats(
    hp: 1,
    attack: 1,
    defense: 1,
    specialAttack: 1,
    specialDefense: 1,
    speed: 1,
  );

  test(
    'should get pokemon stats from repository',
    () async {
      when(() => mockPokemonRepository.getPokemonStats(any()))
          .thenAnswer((_) async => pokemonStats);

      final result = await usecase.call(pokemonName: pokemonName);

      expect(result, pokemonStats);
      verify(() => mockPokemonRepository.getPokemonStats(pokemonName));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
