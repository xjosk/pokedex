import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon_move.dart';

class PokemonMovesView extends ConsumerWidget {
  const PokemonMovesView({
    super.key,
    required this.pokemonMoves,
  });

  final List<PokemonMove> pokemonMoves;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
          height: MediaQuery.of(context).size.height / 2.4,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: pokemonMoves.length,
        itemBuilder: (_, index) => ListTile(
          title: Text('•${pokemonMoves[index].name}'),
          subtitle: Text('Learned at level ${pokemonMoves[index].levelLearnedAt}'),
        ),
        
      ),)
      
    ;
  }
}
