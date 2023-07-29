import 'package:equatable/equatable.dart';

class PokemonPreview extends Equatable {
  const PokemonPreview({
    required this.name,
    required this.types,
  });

  final String name;
  final List<PokemonType> types;

  @override
  List<Object?> get props => [
        name,
        types,
      ];
}

enum PokemonType {
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
}
