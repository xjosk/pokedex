import 'package:equatable/equatable.dart';

class PokemonStats extends Equatable {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  late final int total;

  PokemonStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  }) {
    total = hp + attack + defense + specialAttack + specialDefense + speed;
  }

  @override
  List<Object?> get props => [
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed,
        total,
      ];
}
