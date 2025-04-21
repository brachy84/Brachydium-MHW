import 'package:brachys_armor_set_searcher/bloc/cubits.dart';

import 'equipment.dart';

var currentProfile = Profile('main');

class Profile {
  String name;
  Map<Deco, int> decos = {};
  Map<CharmFamily, int> charms = {};
  int minRarity = 1, maxRarity = 12;
  Set<Armor> blacklistedArmor = {};

  Profile(this.name);

  static init() async {
    // TODO read from file
    currentProfile.decos = { for (var d in All.decos) d : d.maxDecoAmount };
    currentProfile.charms = { for (var c in All.charmFamiliesList) c : c.maxLevel };
  }
}
