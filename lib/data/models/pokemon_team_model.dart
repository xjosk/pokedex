import 'package:pokedex/domain/entities/pokemon_team.dart';

class PokemonTeamModel extends PokemonTeam {
  const PokemonTeamModel({
    required super.id,
    required super.name,
    required super.pokemonNames,
  });

  factory PokemonTeamModel.fromMap(Map<String, dynamic> map) =>
      PokemonTeamModel(
        id: map['id'],
        name: map['name'],
        pokemonNames: (map['pokemonNames'] as List).map((e) => e.toString()).toList(),
      );
}
