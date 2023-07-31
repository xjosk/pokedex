import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon_stats.dart';

class PokemonBaseStatsView extends StatelessWidget {
  const PokemonBaseStatsView({
    super.key,
    required this.pokemonStats,
  });

  final PokemonStats? pokemonStats;

  Text _aboutAttributeLabel(
    String attributeName,
  ) =>
      Text(
        attributeName,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return pokemonStats == null
        ? const Center(
            child: CupertinoActivityIndicator(
              color: Colors.grey,
            ),
          )
        : SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _aboutAttributeLabel('HP'),
                    _aboutAttributeLabel('Attack'),
                    _aboutAttributeLabel('Defense'),
                    _aboutAttributeLabel('Sp. Atk.'),
                    _aboutAttributeLabel('Sp. Def.'),
                    _aboutAttributeLabel('Speed'),
                    _aboutAttributeLabel('Total'),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${pokemonStats!.hp}'),
                    Text('${pokemonStats!.attack}'),
                    Text('${pokemonStats!.defense}'),
                    Text('${pokemonStats!.specialAttack}'),
                    Text('${pokemonStats!.specialDefense}'),
                    Text('${pokemonStats!.speed}'),
                    Text('${pokemonStats!.total}'),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LinearProgressIndicator(
                      value: pokemonStats!.hp / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.attack / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.defense / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.specialAttack / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.specialDefense / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.speed / 255,
                    ),
                    LinearProgressIndicator(
                      value: pokemonStats!.total / 1530,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
