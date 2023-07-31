import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class LogoutUser {
  LogoutUser(this.repository);

  final PokemonRepository repository;

  Future<void> execute() async {
    await repository.removeSessionId();
  }
}
