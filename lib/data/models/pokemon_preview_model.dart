import 'package:pokedex/domain/entities/pokemon_preview.dart';

class PokemonPreviewModel extends PokemonPreview {
  PokemonPreviewModel({
    required super.name,
    required super.types,
    required super.spriteUrl,
  });

  factory PokemonPreviewModel.fromJson(Map<String, dynamic> json) =>
      PokemonPreviewModel(
        name: json['name'],
        types: (json['types'] as List)
            .map(
              (jsonType) => PokemonType.values.firstWhere(
                (enumType) => enumType.name == jsonType['type']['name'],
              ),
            )
            .toList(),
        spriteUrl: json['sprites']['front_default'],
      );
}
