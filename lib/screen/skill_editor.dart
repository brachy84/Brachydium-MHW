import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

import '../bloc/cubits.dart';
import '../data/equipment.dart';

abstract class _AbstractSearcherPageState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  Widget _optionsList(BuildContext context, SearcherArgsState state, SkillSelectorState selectorState,
      double maxHeight) {
    if (!selectorState.shown) return const SizedBox.shrink();
    List<Widget> options = [];
    List<SkillTemplate> skills = List.of(All.skills);
    skills.addAll(All.armorBonuses);
    if (selectorState.searchValue.isEmpty) {
      if (state.skills.isNotEmpty) {
        skills = skills.where((skill) => !state.hasSkill(skill)).toList();
      }
    } else {
      skills =
          skills.where((skill) => skill.matchesSearch(selectorState.searchValue) && !state.hasSkill(skill)).toList();
    }
    if (skills.isEmpty) {
      options.add(const Padding(
        padding: EdgeInsets.all(4),
        child: Row(
          children: [
            Text(
              'No matches',
              style: TextStyle(fontSize: 15),
            ),
            Padding(padding: EdgeInsets.only(left: 4)),
            Icon(
              Icons.accessible_forward,
              color: Colors.red,
            )
          ],
        ),
      ));
    } else {
      skills.sort((a, b) => a.compareForSearch(b, selectorState.searchValue));
      for (SkillTemplate skill in skills) {
        options.add(InkWell(
            onTap: () {
              context.read<SearcherArgsCubit>().addSkill(skill);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                skill.localizedName,
                style: const TextStyle(fontSize: 15),
              ),
            )));
        options.add(const Divider(
          height: 4,
          thickness: 0.5,
        ));
      }
      options.removeLast();
    }
    Color color = const Color.fromARGB(0, 30, 30, 30);
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        double value = Curves.easeOutQuad.transform(_animationController!.value);
        double scale = value * 0.1 + 0.90;
        return Transform.scale(
            scale: scale,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: BlurryContainer(
                  blur: 10,
                  color: color.withAlpha((100 * value + 50).toInt()),
                  padding: const EdgeInsets.all(4),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: child!,
                )));
      },
      child: TapRegion(
        groupId: "skill_selector",
        consumeOutsideTaps: true,
        onTapOutside: (event) {
          _hideOptions(context, selectorState);
        },
        child: ListView(
          shrinkWrap: true,
          children: options,
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, SkillSelectorState state) {
    if (state.shown) return;
    context.read<SkillSelectorCubit>().updateShown(true);
    _animationController!.forward(from: 0);
  }

  void _hideOptions(BuildContext context, SkillSelectorState state) {
    if (!state.shown) return;
    context.read<SkillSelectorCubit>().updateShown(false);
    _animationController!.value = 0;
  }

  void _updateOptions(BuildContext context, String value) {
    context.read<SkillSelectorCubit>().update(true, value);
    _animationController!.forward();
  }

  List<Widget> _buildSkillList(BuildContext context, SearcherArgsState state, bool mobile) {
    List<Widget> skills = [];
    /*_skills.sort((a, b) {
      return b.amount.compareTo(a.amount);
    });*/
    for (Leveled<SkillTemplate> skill in state.skills) {
      skills.add(_skillTile(context, skill, true));
    }
    return skills;
  }

  Widget _skillSelector(SearcherArgsState state, double maxListHeight) {
    //return AutoCompleteField(link: _link);
    return BlocBuilder<SkillSelectorCubit, SkillSelectorState>(
      builder: (context, selectorState) {
        return PortalTarget(
            portalFollower: Material(
              color: Colors.black.withAlpha(0),
              child: _optionsList(context, state, selectorState, maxListHeight),
            ),
            visible: selectorState.shown,
            anchor: const Aligned(
              follower: Alignment.bottomLeft,
              target: Alignment.topLeft,
              portal: Alignment.topCenter,
              //alignToPortal: AxisFlag(y: true, x: true)
            ),
            child: TapRegion(
              groupId: "skill_selector",
              onTapOutside: (event) => _hideOptions(context, selectorState),
              child: TextField(
                controller: _controller,
                onTap: () => _showOptions(context, selectorState),
                onChanged: (val) => _updateOptions(context, val),
                onSubmitted: (val) => _hideOptions(context, selectorState),
                onEditingComplete: () => _hideOptions(context, selectorState),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                    hintText: 'Add Skill',
                    hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                    icon: const Icon(Icons.search)),
              ),
            ));
      },
    );
  }

  Widget _searchButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(minWidth: 300),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.green,
        child: const Text("Search"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _animationController!.dispose();
  }
}

class SkillEditor extends StatefulWidget {
  const SkillEditor({super.key, required this.doneButton});

  final bool doneButton;

  @override
  State<SkillEditor> createState() => _SkillEditorState();
}

class _SkillEditorState extends _AbstractSearcherPageState<SkillEditor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Portal(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Remove All Skills?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
                        ],
                      );
                    }).then((val) {
                  if (val ?? false) {
                    context.read<SearcherArgsCubit>().clearSkills();
                  }
                });
              },
              minWidth: double.infinity,
              height: 48,
              color: Colors.red.withAlpha(150),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: const Text('Remove all skills'),
            ),
            Expanded(
                child: BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
                  buildWhen: (a, b) => !listEquals(a.skills, b.skills),
                  builder: (context, state) {
                    return ListView(
                      children: _buildSkillList(context, state, true),
                    );
                  },
                )),
            _skillSelector(context
                .read<SearcherArgsCubit>()
                .state, 250),
            const SizedBox(
              height: 8,
            ),
            if (widget.doneButton)
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                minWidth: double.infinity,
                height: 48,
                color: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
              )
          ],
        ),
      ),
    );
  }
}

Widget _skillTile(BuildContext context, Leveled<SkillTemplate> skill, bool mobile) {
  int max = skill.value.actualMaxLevel;
  int level = skill.value.getActualLevel(skill.level);
  double sliderMax = max.toDouble();
  double sliderMin = 1.0;
  Widget tile = Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              flex: 66,
              child: Text(
                skill.value.localizedName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )),
          Text('Lv: $level'),
          if (max > 1)
            Expanded(
              flex: 33,
              child: Slider(
                value: clampDouble(level.toDouble(), sliderMin, sliderMax),
                onChanged: (val) {
                  int newLevel = skill.value.getRequiredLevels(val.toInt());
                  if (skill.level != newLevel) {
                    context.read<SearcherArgsCubit>().updateSkillLevel(skill.value, newLevel);
                  }
                },
                min: sliderMin,
                max: sliderMax,
                divisions: max - 1,
              ),
            )
          else
            Expanded(flex: 33, child: Container()),
          if (!mobile)
            IconButton(
                onPressed: () => context.read<SearcherArgsCubit>().removeSkill(skill.value),
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red.shade700,
                ))
        ],
      ));
  if (mobile) {
    return Dismissible(
        key: Key(skill.value.name),
        onDismissed: (dir) => context.read<SearcherArgsCubit>().removeSkill(skill.value),
        child: tile);
  }
  return tile;
}
