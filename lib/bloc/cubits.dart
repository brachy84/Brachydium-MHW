import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:brachys_armor_set_searcher/data/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/equipment.dart';
import '../data/set_finder.dart';

part 'cubits.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.setSearcher);

  void updateScreen(HomeState state) {
    emit(state);
  }
}

enum HomeState { setSearcher, decorations, armorSets, devEditArmor }

class SearcherPageCubit extends Cubit<SearcherPageState> {
  SearcherPageCubit() : super(SearcherPageState.editSkills);

  void updateScreen(SearcherPageState state) {
    emit(state);
  }
}

enum SearcherPageState { editSkills, editDecos, editCharms, editArmorFilters, results }

class SearcherArgsCubit extends Cubit<SearcherArgsState> {
  SearcherArgsCubit() : super(SearcherArgsState.initial());

  SearcherArgsCubit.withState(super.state);

  void update(SearcherArgsState state) {
    emit(state);
  }

  void clearSkills() {
    update(state.copyWith(skills: []));
  }

  void addSkill(SkillTemplate skill) {
    update(state.copyWith(skills: [...state.skills, Leveled(value: skill, level: skill.maxLevel)]));
  }

  void updateSkillLevel(SkillTemplate skill, int level) {
    int i = state.skills.indexWhere((s) => s.value == skill);
    var skills = List.of(state.skills);
    skills[i] = Leveled(value: skill, level: level);
    update(state.copyWith(skills: skills));
  }

  void removeSkill(SkillTemplate skill) {
    var skills = List.of(state.skills);
    skills.removeAt(skills.indexWhere((skill1) => skill1.value == skill));
    update(state.copyWith(skills: skills));
  }

  void useMyDeco(bool val) {
    update(state.copyWith(useAllDecos: !val));
  }

  void _updateDecos(Map<Deco, int> decos) {
    currentProfile.decos = decos;
    update(state.copyWith(decos: decos));
  }

  void updateDecoLevel(Deco deco, int level) {
    var decos = getDecos();
    decos[deco] = level;
    _updateDecos(decos);
  }

  void updateDecoLevelBy(Deco deco, [int by = 1]) {
    var decos = getDecos();
    decos[deco] = min(deco.maxDecoAmount, max(0, (decos[deco] ?? 0) + by));
    _updateDecos(decos);
  }

  void setDecosToMax() {
    _updateDecos({ for (var d in All.decos) d : d.maxDecoAmount });
  }

  void setDecosToZero() {
    _updateDecos({ for (var d in All.decos) d : 0 });
  }

  Map<Deco, int> getDecos() {
    return state.decos != null ? Map.of(state.decos!) : currentProfile.decos;
  }

  void useMyCharms(bool val) {
    update(state.copyWith(useAllCharms: !val));
  }

  void _updateCharms(Map<CharmFamily, int> charms) {
    currentProfile.charms = charms;
    update(state.copyWith(charms: charms));
  }

  void updateCharmLevel(CharmFamily charm, int level) {
    var charms = getCharms();
    charms[charm] = level;
    _updateCharms(charms);
  }

  void updateCharmLevelBy(CharmFamily charm, [int by = 1]) {
    var charms = getCharms();
    charms[charm] = min(charm.maxLevel, max(0, (charms[charm] ?? 0) + by));
    _updateCharms(charms);
  }

  void setCharmsToMax() {
    _updateCharms({ for (var c in All.charmFamiliesList) c : c.maxLevel });
  }

  void setCharmsToZero() {
    _updateCharms({ for (var c in All.charmFamiliesList) c : 0 });
  }

  Map<CharmFamily, int> getCharms() {
    return state.charms != null ? Map.of(state.charms!) : currentProfile.charms;
  }

  void updateRarity(int min, int max) {
    update(state.copyWith(minRarity: min, maxRarity: max));
  }

  void clearBlacklistedEquipment() {
    update(state.copyWith(blacklistedArmors: {}));
  }

  void removeBlacklistedArmor(Armor armor) {
    var set = Set.of(state.blacklistedArmors);
    set.remove(armor);
    update(state.copyWith(blacklistedArmors: set));
  }

  void addBlacklistedArmor(Armor armor) {
    var set = Set.of(state.blacklistedArmors);
    set.add(armor);
    update(state.copyWith(blacklistedArmors: set));
  }
}

@freezed
abstract class SearcherArgsState with _$SearcherArgsState {
  //const factory SearcherState.initial() = _Initial;

  const SearcherArgsState._();

  factory SearcherArgsState.initial() {
    return SearcherArgsState(
        skills: [
      Leveled(value: All.skillsMap['critical-boost']!, level: 5),
      Leveled(value: All.skillsMap['burst']!, level: 5),
      Leveled(value: All.skillsMap['antivirus']!, level: 3),
      Leveled(value: All.skillsMap['weakness-exploit']!, level: 5),
      Leveled(value: All.skillsMap['evade-window']!, level: 3),
      Leveled(value: All.skillsMap['evade-extender']!, level: 1),
      Leveled(value: All.armorBonusesMap['gore-magalas-tyranny']!, level: 2),
      Leveled(value: All.armorBonusesMap['arkvelds-hunger']!, level: 2),
    ],
        blacklistedArmors: {},
        decos: { for (var d in All.decos) d : d.maxDecoAmount },
        useAllDecos: true,
        charms: { for (var c in All.charmFamiliesList) c : c.maxLevel },
        useAllCharms: true,
        minRarity: All.startHighRankRarity,
        maxRarity: All.maxRarity);
  }

  const factory SearcherArgsState({
    required List<Leveled<SkillTemplate>> skills,
    required Set<Armor> blacklistedArmors,
    required Map<Deco, int> decos,
    required bool useAllDecos,
    required Map<CharmFamily, int> charms,
    required bool useAllCharms,
    required int minRarity,
    required int maxRarity
  }) = _SearcherState;

  bool hasSkill(SkillTemplate skill) {
    return skills.any((s) => s.value == skill);
  }

  bool hasArmorBlacklisted(Armor armor) {
    return blacklistedArmors.contains(armor);
  }

  int getDecoAmount(Deco deco) {
    return decos?[deco] ?? deco.maxDecoAmount;
  }
}

class SkillSelectorCubit extends Cubit<SkillSelectorState> {
  SkillSelectorCubit() : super(const SkillSelectorState(searchValue: '', shown: false));

  void updateShown(bool shown) {
    emit(state.copyWith(shown: shown));
  }

  void updateSearchValue(String searchValue) {
    emit(state.copyWith(searchValue: searchValue));
  }

  void update(bool shown, String searchValue) {
    emit(SkillSelectorState(searchValue: searchValue, shown: shown));
  }
}

class SkillSelectorState {
  final String searchValue;
  final bool shown;

  const SkillSelectorState({required this.searchValue, required this.shown});

  SkillSelectorState copyWith({String? searchValue, bool? shown}) =>
      SkillSelectorState(searchValue: searchValue ?? this.searchValue, shown: shown ?? this.shown);
}

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit() : super(SearchResultState(null, false));

  void startSearch(SearcherArgsState searcherState) async {
    var result = SearchResultState(SearchManager.searchAllArmorCombinations(SearchArguments.of(
        weapon: All.dummyWeapon,
        requiredSkills: searcherState.skills,
        decorations: searcherState.decos,
        charms: searcherState.charms,
        minRarity: searcherState.minRarity,
        maxRarity: searcherState.maxRarity,
        blacklistedArmor: searcherState.blacklistedArmors)), true);
    result.searchResult!.armorSetStream.controller.onCancel = () => _onFinish();
    emit(result);
  }

  void _onFinish() {
    emit(SearchResultState(state.searchResult, false));
  }
}

class SearchResultState {
  final SearchResult? searchResult;
  final bool searching;

  SearchResultState(this.searchResult, this.searching);

  bool get hasResult => searchResult != null;
}
