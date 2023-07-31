import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_preview.dart';

extension PokemonColorType on PokemonType {
  Color get colorType {
    switch (this) {
      case PokemonType.normal:
        return const Color(0xffACAD99);
      case PokemonType.fighting:
        return const Color(0xffC45D4C);
      case PokemonType.flying:
        return const Color(0xff90AAD7);
      case PokemonType.poison:
        return const Color(0xffB369AF);
      case PokemonType.ground:
        return const Color(0xffCEB250);
      case PokemonType.rock:
        return const Color(0xffBAA85E);
      case PokemonType.bug:
        return const Color(0xffACC23E);
      case PokemonType.ghost:
        return const Color(0xff816DB6);
      case PokemonType.steel:
        return const Color(0xff9FA9AF);
      case PokemonType.fire:
        return const Color(0xffE87A3D);
      case PokemonType.water:
        return const Color(0xff639CE4);
      case PokemonType.grass:
        return const Color(0xff82C95B);
      case PokemonType.electric:
        return const Color(0xffE7C536);
      case PokemonType.psychic:
        return const Color(0xffE96C95);
      case PokemonType.ice:
        return const Color(0xff81CFD7);
      case PokemonType.dragon:
        return const Color(0xff8572C8);
      case PokemonType.dark:
        return const Color(0xff79726B);
      case PokemonType.fairy:
        return const Color(0xffE8B0EB);
    }
  }
}