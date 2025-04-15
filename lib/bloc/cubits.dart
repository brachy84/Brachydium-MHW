import 'package:bloc/bloc.dart';
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

@immutable
enum HomeState { setSearcher, decorations, armorSets }

class SearcherPageCubit extends Cubit<SearcherPageState> {
  SearcherPageCubit() : super(SearcherPageState.editSkills);

  void updateScreen(SearcherPageState state) {
    emit(state);
  }
}

enum SearcherPageState { editSkills, editDecos, editArmorFilters }

class SearcherCubit extends Cubit<SearcherState> {
  SearcherCubit() : super(SearcherState.initial());

  void update(SearcherState state) {
    emit(state);
  }

  void clearSkills() {
    update(state.copyWith(skills: []));
  }

  void addSkill(Skill skill) {
    update(state.copyWith(skills: [...state.skills, Stack(value: skill, amount: skill.maxLevel)]));
  }

  void updateSkillLevel(Skill skill, int level) {
    int i = state.skills.indexWhere((s) => s.value == skill);
    var skills = List.of(state.skills);
    skills[i] = Stack(value: skill, amount: level);
    update(state.copyWith(skills: skills));
  }

  void removeSkill(Skill skill) {
    var skills = List.of(state.skills);
    skills.removeAt(skills.indexWhere((skill1) => skill1.value == skill));
    update(state.copyWith(skills: skills));
  }

  void useMyDeco(bool val) {
    update(state.copyWith(useMyDeco: val));
  }
}

@freezed
class SearcherState with _$SearcherState {
  //const factory SearcherState.initial() = _Initial;

  const SearcherState._();

  factory SearcherState.initial() {
    return SearcherState(skills: [
      Stack(value: All.skillsMap['critical-boost']!, amount: 5),
      Stack(value: All.skillsMap['burst']!, amount: 5),
      Stack(value: All.skillsMap['antivirus']!, amount: 3),
      Stack(value: All.skillsMap['weakness-exploit']!, amount: 5)
    ], armorFilters: [], useMyDeco: true);
  }

  const factory SearcherState({
    required List<Stack<Skill>> skills,
    required List<Stack<ArmorFilter>> armorFilters,
    required bool useMyDeco,
  }) = _SearcherState;

  bool hasSkill(Skill skill) {
    return skills.any((s) => s.value == skill);
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
  SearchResultCubit() : super(SearchResultState(null));

  void startSearch(SearcherState searcherState) async {
    emit(SearchResultState(await searchAllArmorCombinations(SearchArguments.of(
        weapon: All.dummyWeapon,
        requiredSkills: searcherState.skills,
        decorations: null,
        charms: null,
        minRarity: 0,
        maxRarity: 12,
        blacklistedArmor: {},
        weaponSlots: [3, 3, 3]))));
  }
}

class SearchResultState {
  final SearchResult? searchResult;

  SearchResultState(this.searchResult);

  bool get hasResult => searchResult != null;
}
