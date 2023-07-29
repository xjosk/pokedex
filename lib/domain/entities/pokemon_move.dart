import 'package:equatable/equatable.dart';

class PokemonMove extends Equatable {
  final String name;
  final int learnedAtLevel;

  const PokemonMove({
    required this.name,
    required this.learnedAtLevel,
  });

  @override
  List<Object?> get props => [
    name,
    learnedAtLevel,
  ];
}
