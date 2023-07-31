import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/extensions/pokemon_type_extension.dart';
import 'package:pokedex/injection_container.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_about_view.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_base_stats_view.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_details_provider.dart';
import 'package:pokedex/presentation/pokemon_details/pokemon_moves_view.dart';
import '../../domain/entities/pokemon_preview.dart';

class PokemonDetailsPage extends ConsumerStatefulWidget {
  const PokemonDetailsPage({super.key, required this.pokemonPreview});

  final PokemonPreview pokemonPreview;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends ConsumerState<PokemonDetailsPage> {
  void _getPokemonAbout() async {
    final obtainedPokemonAbout = await ref.read(getPokemonAbout).call(
          pokemonName: widget.pokemonPreview.name.toLowerCase(),
        );
    ref.read(pokemonAbout.notifier).state = obtainedPokemonAbout;
  }

  void _getPokemonStats() async {
    final obtainedPokemonStats = await ref.read(getPokemonStats).call(
          pokemonName: widget.pokemonPreview.name.toLowerCase(),
        );
    ref.read(pokemonStats.notifier).state = obtainedPokemonStats;
  }

  void _getPokemonMoves() async {
    final obtainedPokemonMoves = await ref.read(getPokemonMoves).call(
          pokemonName: widget.pokemonPreview.name.toLowerCase(),
        );
    ref.read(pokemonMoves.notifier).state = obtainedPokemonMoves;
  }

  @override
  void initState() {
    super.initState();
    _getPokemonAbout();
  }

  double value = 1 / 3;

  @override
  Widget build(BuildContext context) {
    final statePokemonAbout = ref.watch(pokemonAbout);
    final statePokemonStats = ref.watch(pokemonStats);
    final statePokemonMoves = ref.watch(pokemonMoves);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.pokemonPreview.types.length > 1
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.pokemonPreview.types
                      .map((e) => e.colorType)
                      .toList(),
                )
              : null,
          color: widget.pokemonPreview.types.length > 1
              ? null
              : widget.pokemonPreview.types.first.colorType,
        ),
        child: statePokemonAbout == null
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                ),
              )
            : Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.pokemonPreview.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0,
                              ),
                            ),
                            Row(
                              children: widget.pokemonPreview.types
                                  .map(
                                    (e) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: e.colorType,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 0.5,
                                              blurRadius: 3,
                                              offset: const Offset(1,
                                                  4), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          e.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.25,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () {
                                        setState(() => value = 1 / 3);
                                      },
                                      child: const Text('About'),
                                    ),
                                  ),
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () {
                                        setState(() => value = 2 / 3);
                                        _getPokemonStats();
                                      },
                                      child: const Text('Base stats'),
                                    ),
                                  ),
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () {
                                        setState(() => value = 1);
                                        _getPokemonMoves();
                                      },
                                      child: const Text('Moves'),
                                    ),
                                  ),
                                ],
                              ),
                              LinearProgressIndicator(value: value),
                              const SizedBox(
                                height: 25,
                              ),
                              if (value == 1 / 3)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: PokemonAboutView(
                                    pokemonAbout: statePokemonAbout,
                                  ),
                                ),
                              if (value == 2 / 3)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: PokemonBaseStatsView(
                                    pokemonStats: statePokemonStats,
                                  ),
                                ),
                              if (value == 1)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: PokemonMovesView(pokemonMoves: statePokemonMoves,),
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, -0.50),
                    child: IgnorePointer(
                      ignoring: true,
                      child: Image.network(
                        widget.pokemonPreview.spriteUrl,
                        scale: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
