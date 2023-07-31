import 'package:pokedex/domain/entities/pokemon_move.dart';

class PokemonMoveModel extends PokemonMove {
  PokemonMoveModel({
    required super.name,
    required super.levelLearnedAt,
  });

  factory PokemonMoveModel.fromJson(Map<String, dynamic> json) =>
      PokemonMoveModel(
        name: json['move']['name'],
        levelLearnedAt:
            (json['version_group_details'] as List).first['level_learned_at'],
      );
}
