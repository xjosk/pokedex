import 'package:equatable/equatable.dart';

class PokemonAbout extends Equatable {
  final String species;
  final String height;
  final String weight;
  final List<String> abilites;
  final String gender;
  final String eggGroup;
  final String eggCycle;

  const PokemonAbout({
    required this.species,
    required this.height,
    required this.weight,
    required this.abilites,
    required this.gender,
    required this.eggGroup,
    required this.eggCycle,
  });

  @override
  List<Object?> get props => [
    species,
    height,
    weight,
    abilites,
    gender,
    eggGroup,
    eggCycle,
  ];
}
