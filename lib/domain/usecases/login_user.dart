import '../repositories/pokemon_repository.dart';

class LoginUser {
  LoginUser(this.repository);

  final PokemonRepository repository;

  Future<bool> execute({
    required String username,
    required String password,
  }) async {
    final userId = await repository.login(
      username: username,
      password: password,
    );
    if (userId == 0) return false;
    await repository.setSessionId(userId);
    return true;
  }
}
