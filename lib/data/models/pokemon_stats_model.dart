import 'package:pokedex/domain/entities/pokemon_stats.dart';

class PokemonStatsModel extends PokemonStats {
  PokemonStatsModel({
    required super.hp,
    required super.attack,
    required super.defense,
    required super.specialAttack,
    required super.specialDefense,
    required super.speed,
  });

  factory PokemonStatsModel.fromJson(Map<String, dynamic> json) {
    final statList = json['stats'] as List;
    final newJson = statList.map(
      (e) => {
        'base_stat': e['base_stat'],
        'name': e['stat']['name'],
      },
    );

    return PokemonStatsModel(
      hp: newJson.firstWhere((e) => e['name'] == 'hp')['base_stat'],
      attack: newJson.firstWhere((e) => e['name'] == 'attack')['base_stat'],
      defense: newJson.firstWhere((e) => e['name'] == 'defense')['base_stat'],
      specialAttack:
          newJson.firstWhere((e) => e['name'] == 'special-attack')['base_stat'],
      specialDefense: newJson
          .firstWhere((e) => e['name'] == 'special-defense')['base_stat'],
      speed: newJson.firstWhere((e) => e['name'] == 'speed')['base_stat'],
    );
  }
}
