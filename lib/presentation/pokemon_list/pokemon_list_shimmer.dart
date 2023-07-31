import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PokemonListShimmer extends StatelessWidget {
  const PokemonListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4 / 3,
      ),
      itemCount: 12,
      itemBuilder: (_, index) {
        return Container(
          margin: (index == 0 || index == 1)
              ? const EdgeInsets.only(top: 10.0)
              : null,
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: const Color.fromARGB(255, 205, 205, 205),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
