import 'package:equatable/equatable.dart';
import 'package:pokedex/core/extensions/string_extension.dart';

class PokemonAbout extends Equatable {
  final String species;
  late final double height;
  late final double weight;
  late final List<String> abilites;
  late final double femaleGenderRate;
  late final List<String> eggGroups;
  final int eggCycle;

  PokemonAbout({
    required this.species,
    required int height,
    required int weight,
    required List<String> abilites,
    required int femaleGenderRate,
    required List<String> eggGroups,
    required this.eggCycle,
  }) {
    this.height = height * 10;
    this.weight = weight / 10;
    this.femaleGenderRate = femaleGenderRate / 8;
    this.abilites = abilites.map((e) => e.capitalizeFirstWord).toList();
    this.eggGroups = eggGroups.map((e) => e.capitalizeFirstWord).toList();
  }

  @override
  List<Object?> get props => [
        species,
        height,
        weight,
        abilites,
        femaleGenderRate,
        eggGroups,
        eggCycle,
      ];
}
