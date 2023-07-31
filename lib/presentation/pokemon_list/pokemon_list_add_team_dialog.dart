import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/injection_container.dart';
import 'package:pokedex/presentation/pokemon_list/pokemon_list_provider.dart';

class PokemonListAddTeamDialog extends ConsumerStatefulWidget {
  const PokemonListAddTeamDialog({
    super.key,
    required this.selectedPokemon,
  });

  final List<String> selectedPokemon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListAddTeamState();
}

class _PokemonListAddTeamState extends ConsumerState<PokemonListAddTeamDialog> {
  final _teamNameController = TextEditingController();

  void _popDialog() => Navigator.of(context).pop();

  bool didCreateATeam = false;

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Team name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          didCreateATeam
              ? const Text('Pokemon team created!')
              : CupertinoTextField(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  controller: _teamNameController,
                ),
        ],
      ),
      actions: didCreateATeam
          ? [
              CupertinoButton(
                onPressed: _popDialog,
                child: const Text('Ok'),
              ),
            ]
          : [
              CupertinoButton(
                onPressed: _popDialog,
                child: const Text('Cancel'),
              ),
              CupertinoButton(
                onPressed: () async {
                  if (_teamNameController.text.trim().isNotEmpty) {
                    await ref.read(createPokemonTeam).execute(
                          pokemonNames: widget.selectedPokemon,
                          teamName: _teamNameController.text,
                        );
                    setState(() => didCreateATeam = true);
                    ref.read(areTeamsBeingCreated.notifier).state = false;
                    ref.read(selectedPokemon.notifier).clear();
                  }
                },
                child: const Text('Create team'),
              ),
            ],
    );
  }
}
