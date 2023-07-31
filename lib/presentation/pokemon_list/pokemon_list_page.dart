import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/extensions/pokemon_type_extension.dart';
import 'package:pokedex/injection_container.dart';
import 'package:pokedex/presentation/login/login_page.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_details_page.dart';
import 'package:pokedex/presentation/pokemon_list/pokemon_list_add_team_dialog.dart';
import 'package:pokedex/presentation/pokemon_list/pokemon_list_provider.dart';
import 'package:pokedex/presentation/pokemon_list/pokemon_list_shimmer.dart';
import 'package:pokedex/presentation/pokemon_team/pokemon_team_page.dart';
import 'package:shimmer/shimmer.dart';

class PokemonListPage extends ConsumerStatefulWidget {
  const PokemonListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListPageState();
}

class _PokemonListPageState extends ConsumerState<PokemonListPage> {
  final _scrollController = ScrollController();

  void _logout() async {
    await ref.read(logoutUser).execute();
    _loginPage();
  }

  void _loginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  void _getInitialPokemonPreviews() async {
    final obtainedPokemonPreviews = await ref.read(getPokemon).call(offset: 0);
    ref.read(pokemonPreviews.notifier).addAll(obtainedPokemonPreviews);
  }

  void _loadMorePokemonPreviews() async {
    final offset = ref.read(offsetProvider) + 12;
    ref.read(offsetProvider.notifier).state = offset;
    final obtainedPokemonPreviews =
        await ref.read(getPokemon).call(offset: offset);
    ref.read(pokemonPreviews.notifier).addAll(obtainedPokemonPreviews);
  }

  @override
  void initState() {
    super.initState();
    _getInitialPokemonPreviews();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _loadMorePokemonPreviews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final statePokemonPreviews = ref.watch(pokemonPreviews);
    final watchSelectedPokemon = ref.watch(selectedPokemon);
    final stateSelectedPokemon = ref.read(selectedPokemon.notifier);
    final stateAreTeamsBeingCreated = ref.watch(areTeamsBeingCreated);

    return Scaffold(
      appBar: stateAreTeamsBeingCreated
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              title: Text(
                'Selected pokemon (${watchSelectedPokemon.length})',
                style: const TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (watchSelectedPokemon.length == 6) {
                      await showDialog(
                        context: context,
                        builder: (_) => PokemonListAddTeamDialog(
                          selectedPokemon: watchSelectedPokemon,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => const PokemonTeamPage(),
                    ),
                  ),
                  icon: const Icon(Icons.group),
                ),
                IconButton(
                  onPressed: () => _logout(),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (stateAreTeamsBeingCreated) stateSelectedPokemon.clear();
          ref.read(areTeamsBeingCreated.notifier).state =
              !stateAreTeamsBeingCreated;
        },
        child: const Icon(Icons.tune),
      ),
      body: statePokemonPreviews == null
          ? const Text("Couldn't get any pokemon :(")
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: statePokemonPreviews.isEmpty
                  ? const PokemonListShimmer()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4 / 3,
                      ),
                      itemCount: statePokemonPreviews.length + 2,
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        final widgetIndex = index < statePokemonPreviews.length
                            ? index
                            : index - 2;
                        final pokemonPreview =
                            statePokemonPreviews[widgetIndex];

                        return index < statePokemonPreviews.length
                            ? pokemonPreview == null
                                ? const Text("Couldn't retrieve this pokemon.")
                                : GestureDetector(
                                    onTap: stateAreTeamsBeingCreated
                                        ? () {
                                            if (watchSelectedPokemon.contains(
                                                pokemonPreview.name)) {
                                              stateSelectedPokemon
                                                  .remove(pokemonPreview.name);
                                            } else {
                                              if (watchSelectedPokemon.length !=
                                                  6) {
                                                stateSelectedPokemon
                                                    .add(pokemonPreview.name);
                                              }
                                            }
                                          }
                                        : () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (_) =>
                                                        PokemonDetailsPage(
                                                            pokemonPreview:
                                                                pokemonPreview)));
                                          },
                                    child: Transform.scale(
                                      scale: watchSelectedPokemon
                                              .contains(pokemonPreview.name)
                                          ? 0.9
                                          : 1,
                                      child: Container(
                                        margin: (widgetIndex == 0 ||
                                                widgetIndex == 1)
                                            ? const EdgeInsets.only(top: 10.0)
                                            : null,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          gradient: pokemonPreview
                                                      .types.length >
                                                  1
                                              ? LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: pokemonPreview.types
                                                      .map((e) => e.colorType)
                                                      .toList(),
                                                )
                                              : null,
                                          color: pokemonPreview.types.length > 1
                                              ? null
                                              : pokemonPreview
                                                  .types.first.colorType,
                                        ),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    pokemonPreview.name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0),
                                                  ),
                                                  ...pokemonPreview.types.map(
                                                    (e) => Container(
                                                      width: 60,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                        color: e.colorType,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 0.5,
                                                            blurRadius: 3,
                                                            offset: const Offset(
                                                                1,
                                                                4), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        e.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Image.network(
                                                  pokemonPreview.spriteUrl),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor:
                                    const Color.fromARGB(255, 205, 205, 205),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                      },
                    ),
            ),
    );
  }
}
