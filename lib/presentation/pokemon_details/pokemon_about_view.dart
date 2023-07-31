import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon_about.dart';

class PokemonAboutView extends StatelessWidget {
  const PokemonAboutView({
    super.key,
    required this.pokemonAbout,
  });

  final PokemonAbout pokemonAbout;

  SizedBox _labelSpacing([
    double height = 25,
  ]) =>
      SizedBox(
        height: height,
      );

  Row _attributes(
    String attributeName,
    String attribute,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              attributeName,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            flex: 6,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                attribute,
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _attributes('Species', pokemonAbout.species),
          _attributes('Height', '${pokemonAbout.height.toString()} cm'),
          _attributes('Weight', '${pokemonAbout.weight.toString()} kg'),
          _attributes('Abilites',
              '${pokemonAbout.abilites}'.replaceAll(RegExp(r'[\[\]]'), '')),
          const Text(
            'Breeding',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
              flex: 2,
              child: Text(
                'Gender',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
              Flexible(
                flex: 6,
                child: Row(
                  children: [
                    const Icon(
                      Icons.male,
                      color: Color.fromARGB(255, 96, 202, 250),
                    ),
                    Text('${(1 - pokemonAbout.femaleGenderRate) * 100}%'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.female, color: Color.fromARGB(255, 255, 198, 217)),
                    Text('${pokemonAbout.femaleGenderRate * 100}%'),
                  ],
                ),
              ),
            ],
          ),
          _attributes('Egg Groups',
              '${pokemonAbout.eggGroups}'.replaceAll(RegExp(r'[\[\]]'), '')),
          _attributes('Egg Cycle', pokemonAbout.eggCycle.toString()),
        ],
      ),
    );
  }
}
