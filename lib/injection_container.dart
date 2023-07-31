import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/create_pokemon_team.dart';
import 'package:pokedex/domain/usecases/get_pokemon.dart';
import 'package:pokedex/domain/usecases/get_pokemon_moves.dart';
import 'package:pokedex/domain/usecases/get_pokemon_stats.dart';
import 'package:pokedex/domain/usecases/get_pokemon_teams.dart';
import 'package:pokedex/domain/usecases/get_session_id.dart';
import 'package:pokedex/domain/usecases/login_user.dart';
import 'package:pokedex/domain/usecases/logout_user.dart';
import 'package:pokedex/domain/usecases/signup_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain/usecases/get_pokemon_about.dart';
import 'domain/usecases/get_pokemon_from_name.dart';

late final Provider<GetPokemon> getPokemon;
late final Provider<GetPokemonAbout> getPokemonAbout;
late final Provider<GetPokemonStats> getPokemonStats;
late final Provider<GetPokemonMoves> getPokemonMoves;
late final Provider<GetSessionId> getSessionId;
late final Provider<SignupUser> signupUser;
late final Provider<LogoutUser> logoutUser;
late final Provider<LoginUser> loginUser;
late final Provider<CreatePokemonTeam> createPokemonTeam;
late final Provider<GetPokemonTeams> getPokemonTeams;
late Provider<GetPokemonFromName> getPokemonFromName;

Future<void> init() async {
  final PokemonRemoteDatasource pokemonRemoteDatasource =
      PokemonRemoteDatasourceImpl(http.Client());
  final PokemonLocalDatasource pokemonLocalDatasource =
      PokemonLocalDatasourceImpl(await SharedPreferences.getInstance());
  final PokemonRepository pokemonRepository = PokemonRepositoryImpl(
    pokemonRemoteDatasource: pokemonRemoteDatasource,
    pokemonLocalDatasource: pokemonLocalDatasource,
  );

  getPokemon = Provider<GetPokemon>(
    (ref) => GetPokemon(pokemonRepository),
  );
  getPokemonAbout = Provider<GetPokemonAbout>(
    (ref) => GetPokemonAbout(pokemonRepository),
  );
  getPokemonStats =
      Provider<GetPokemonStats>((ref) => GetPokemonStats(pokemonRepository));
  getPokemonMoves =
      Provider<GetPokemonMoves>((ref) => GetPokemonMoves(pokemonRepository));
  getSessionId =
      Provider<GetSessionId>((ref) => GetSessionId(pokemonRepository));
  signupUser = Provider<SignupUser>((ref) => SignupUser(pokemonRepository));
  logoutUser = Provider<LogoutUser>((ref) => LogoutUser(pokemonRepository));
  loginUser = Provider<LoginUser>((ref) => LoginUser(pokemonRepository));
  createPokemonTeam = Provider<CreatePokemonTeam>(
      (ref) => CreatePokemonTeam(pokemonRepository));
  getPokemonTeams =
      Provider<GetPokemonTeams>((ref) => GetPokemonTeams(pokemonRepository));
  getPokemonFromName = Provider<GetPokemonFromName>(
      (ref) => GetPokemonFromName(pokemonRepository));
}
