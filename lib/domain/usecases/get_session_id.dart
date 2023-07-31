import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class GetSessionId {
  GetSessionId(this.repository);

  final PokemonRepository repository;

  int call() => repository.getSessionId();
}
