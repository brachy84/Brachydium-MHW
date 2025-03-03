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
  SearcherCubit() : super(const SearcherState(skills: [], armorFilters: [], useMyDeco: true));

  void update(SearcherState state) {
    emit(state);
  }

  void clearSkills() {
    update(state.copyWith(skills: []));
  }

  void addSkill(Skill skill) {
    update(state.copyWith(skills: [...state.skills, Stack(value: skill, amount: skill.cappedMaxLevel)]));
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
