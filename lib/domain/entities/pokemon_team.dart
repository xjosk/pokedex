import 'package:equatable/equatable.dart';

class PokemonTeam extends Equatable {
  const PokemonTeam({
    required this.id,
    required this.name,
    required this.pokemonNames,
  });

  final int id;
  final String name;
  final List<String> pokemonNames;

  @override
  List<Object?> get props => [];
}
