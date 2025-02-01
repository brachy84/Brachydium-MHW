import 'equipment.dart';

class Profile {
  final String name;
  final Map<Deco, int>? decos;
  final List<Charm>? charms;
  final int minRarity, maxRarity;
  final Set<Armor> blacklistedArmor;

  Profile(this.name, {required this.decos, required this.charms, this.minRarity = 1, this.maxRarity = 12, required this.blacklistedArmor});
}
