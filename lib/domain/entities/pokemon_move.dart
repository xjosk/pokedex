import 'package:equatable/equatable.dart';
import 'package:pokedex/core/extensions/string_extension.dart';

class PokemonMove extends Equatable {
  late final String name;
  final int levelLearnedAt;

  PokemonMove({
    required String name,
    required this.levelLearnedAt,
  }) {
    this.name = name.capitalizeFirstWord;
  }

  @override
  List<Object?> get props => [
        name,
        levelLearnedAt,
      ];
}
