import 'package:equatable/equatable.dart';
import 'package:pokedex/core/extensions/string_extension.dart';

class PokemonPreview extends Equatable {
  PokemonPreview({
    required String name,
    required this.types,
    required this.spriteUrl,
  }) {
    this.name = name.capitalizeFirstWord;
  }

  late final String name;
  final List<PokemonType> types;
  final String spriteUrl;

  @override
  List<Object?> get props => [
        name,
        types,
        spriteUrl,
      ];
}

enum PokemonType {
  normal,
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
