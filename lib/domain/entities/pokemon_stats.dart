import 'package:equatable/equatable.dart';

class PokemonStats extends Equatable {
  final int hp;
  final int attack;
  final int defense;
  final int speedAttack;
  final int speedDefense;
  final int speed;
  late final int total;

  PokemonStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speedAttack,
    required this.speedDefense,
    required this.speed,
  }) {
    total = hp + attack + defense + speedAttack + speedDefense + speed;
  }

  @override
  List<Object?> get props => [
        hp,
        attack,
        defense,
        speedAttack,
        speedDefense,
        speed,
        total,
      ];
}
