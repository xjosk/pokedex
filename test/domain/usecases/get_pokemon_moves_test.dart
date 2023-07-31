import 'package:mocktail/mocktail.dart';
import 'package:pokedex/domain/entities/pokemon_move.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/usecases/get_pokemon_moves.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemonMoves usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonMoves(mockPokemonRepository);
  });

  const pokemonName = 'bulbasur';
  final pokemonMoves = List.generate(
    3,
    (index) => PokemonMove(
      name: 'cut',
      levelLearnedAt: 24,
    ),
  );

  test(
    'should get moves (3) from pokemon from repository',
    () async {
      when(() => mockPokemonRepository.getPokemonMoves(any()))
          .thenAnswer((_) async => pokemonMoves);

      final result = await usecase.call(pokemonName: pokemonName);

      expect(result, pokemonMoves);
      verify(() => mockPokemonRepository.getPokemonMoves(pokemonName));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
