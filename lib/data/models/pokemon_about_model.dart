import 'package:pokedex/domain/entities/pokemon_about.dart';

class PokemonAboutModel extends PokemonAbout {
  PokemonAboutModel({
    required super.species,
    required super.height,
    required super.weight,
    required super.abilites,
    required super.femaleGenderRate,
    required super.eggGroups,
    required super.eggCycle,
  });

  factory PokemonAboutModel.fromJson(Map<String, dynamic> json) =>
      PokemonAboutModel(
        species: (json['genera'] as List)
            .firstWhere((e) => e['language']['name'] == 'en')['genus'],
        height: json['height'],
        weight: json['weight'],
        abilites: (json['abilities'] as List)
            .map<String>((e) => e['ability']['name'])
            .toList(),
        femaleGenderRate: json['gender_rate'],
        eggGroups:
            (json['egg_groups'] as List).map<String>((e) => e['name']).toList(),
        eggCycle: json['hatch_counter'],
      );
}
