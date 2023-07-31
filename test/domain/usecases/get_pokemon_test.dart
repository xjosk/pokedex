import 'package:mocktail/mocktail.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/domain/usecases/get_pokemon.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late GetPokemon usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemon(mockPokemonRepository);
  });

  const offset = 10;
  final List<PokemonPreview> pokemonPreviews = List.generate(
    10,
    (index) => PokemonPreview(
      name: 'bulbasur',
      types: const <PokemonType>[],
      spriteUrl: 'http...'
    ),
  );

  test(
    'should get (10) pokemon previews from repository',
    () async {
      when(() => mockPokemonRepository.getPokemon(any()))
          .thenAnswer((_) async => pokemonPreviews);

      final result = await usecase.call(offset: offset);

      expect(result, pokemonPreviews);
      verify(() => mockPokemonRepository.getPokemonFromUrls(offset)).called(1);
    },
  );
}
