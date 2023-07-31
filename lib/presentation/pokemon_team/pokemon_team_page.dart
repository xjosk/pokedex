import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_team.dart';
import 'package:pokedex/injection_container.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_details_page.dart';

import '../../domain/entities/pokemon_preview.dart';
import 'pokemon_team_provider.dart';

class PokemonTeamPage extends ConsumerStatefulWidget {
  const PokemonTeamPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonTeamPageState();
}

class _PokemonTeamPageState extends ConsumerState<PokemonTeamPage> {
  void _getPokemonTeams() async {
    final obtainedPokemonTeams = await ref.read(getPokemonTeams).call();
    ref.read(pokemonTeamsProvider.notifier).replace(obtainedPokemonTeams);
  }

  void _pokemonDetails(Future<PokemonPreview> pokemonPreviewFuture) {
    final retrieveState = ref.read(isPokemonBeingRetrieved.notifier);
    retrieveState.state = true;
    pokemonPreviewFuture
        .then(
          (value) => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => PokemonDetailsPage(
                pokemonPreview: value,
              ),
            ),
          ),
        )
        .whenComplete(() => retrieveState.state = false);
  }

  @override
  void initState() {
    super.initState();
    _getPokemonTeams();
  }

  int currentPokemonIndex = 0;
  int currentTeamIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pokemonTeams = ref.watch(pokemonTeamsProvider);
    final pokemonRetrieveState = ref.watch(isPokemonBeingRetrieved);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon Teams',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: pokemonTeams == null
          ? const Center(
              child: CupertinoActivityIndicator(
                color: Colors.grey,
              ),
            )
          : pokemonTeams.isEmpty
              ? const Center(
                  child: Text('There are no teams... yet!'),
                )
              : ListView.builder(
                  itemCount: pokemonTeams.length,
                  itemBuilder: (_, index) {
                    final pokemonTeam = pokemonTeams[index];

                    return ExpansionTile(
                      title: Text(pokemonTeam.name),
                      children: [
                        ...pokemonTeam.pokemonNames.map((e) {
                          final pokemonIndex =
                              pokemonTeam.pokemonNames.indexOf(e);
                          return InkWell(
                            onTap: () async {
                              currentPokemonIndex = pokemonIndex;
                              currentTeamIndex = index;
                              setState(() {});

                              _pokemonDetails(
                                  ref.read(getPokemonFromName).call(e));
                            },
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${pokemonIndex + 1}. $e'),
                                  Visibility(
                                    visible: currentTeamIndex == index
                                        ? currentPokemonIndex == pokemonIndex
                                            ? pokemonRetrieveState
                                            : false
                                        : false,
                                    child: const CupertinoActivityIndicator(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
    );
  }
}
