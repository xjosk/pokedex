import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/domain/entities/pokemon_preview.dart';

class MockPokemonRemoteDatasource extends Mock
    implements PokemonRemoteDatasource {}

class MockPokemonLocalDataSource extends Mock
    implements PokemonLocalDatasource {}

void main() {
  late MockPokemonRemoteDatasource mockPokemonRemoteDatasource;
  late PokemonRepositoryImpl pokemonRepositoryImpl;
  late PokemonLocalDatasource mockPokemonLocalDatasource;

  final pokemonPreview = PokemonPreview(
    name: 'bulb',
    types: const <PokemonType>[],
    spriteUrl: 'url',
  );
  final pokemonUrls = List.generate(10, (index) => 'url/$index');
  const offset = 0;

  setUp(() {
    mockPokemonRemoteDatasource = MockPokemonRemoteDatasource();
    mockPokemonLocalDatasource = MockPokemonLocalDataSource();
    pokemonRepositoryImpl = PokemonRepositoryImpl(
        pokemonRemoteDatasource: mockPokemonRemoteDatasource,
        pokemonLocalDatasource: mockPokemonLocalDatasource);
  });

  group('getPokemon', () {
    group('if call to api is successful', () {
      group('pokemonUrls', () {
        setUp(() {
          when(() => mockPokemonRemoteDatasource.getPokemonUrls(offset))
              .thenAnswer((_) async => pokemonUrls);
        });
        test(
          'should check if it was called once',
          () async {
            await pokemonRepositoryImpl.getPokemonFromUrls(offset);

            verify(() => mockPokemonRemoteDatasource.getPokemonUrls(offset))
                .called(1);
          },
        );
      });

      group('getPokemonPreview', () {
        setUp(() {
          when(() => mockPokemonRemoteDatasource.getPokemonPreview(any()))
              .thenAnswer((_) async => pokemonPreview);
        });

        test(
          'should check if it was called 10 times',
          () async {
            await pokemonRepositoryImpl.getPokemon(pokemonUrls);

            verify(() => mockPokemonRemoteDatasource.getPokemonPreview(any()))
                .called(10);
          },
        );
      });
    });

    group('if call to api failed', () {
      setUp(() {
        when(() => mockPokemonRemoteDatasource.getPokemonUrls(offset))
            .thenAnswer((_) => Future.error(Exception()));
      });
      test(
        'should catch any exception',
        () async {
          try {
            final pokemonList =
                await pokemonRepositoryImpl.getPokemonFromUrls(offset);
          } catch (e) {
            verify(() => mockPokemonRemoteDatasource.getPokemonUrls(offset))
                .called(1);
            expect(e, isA<Exception>());
          }
        },
      );
    });
  });
}
