import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart' as ass;

import '../data/equipment.dart';

Widget _option(BuildContext context, String title, SearcherPageState pageState, Widget child) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withAlpha(20),
      onPressed: () {
        context.read<SearcherPageCubit>().updateScreen(pageState);
        //Navigator.of(context).push<void>(MaterialPageRoute(builder: (context) => SimplePage(body: page, title: title)));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: double.infinity),
            //child: SizedBox(height: 60,),
            child: child,
          )
        ],
      ),
    ),
  );
}

Widget _makeSkillChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.red.shade800),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    ),
  );
}

Widget _skillsPreview(BuildContext context, SearcherState state) {
  if (state.skills.isEmpty) {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text('None selected'),
    );
  }
  List<Widget> skills = state.skills.map((skill) => _makeSkillChip("${skill.value.name} ${skill.amount}")).toList();
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    alignment: WrapAlignment.spaceEvenly,
    children: skills,
  );
}

Widget _decosOption(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withAlpha(20)
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Decorations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(30)),
            margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: double.infinity),
            //child: SizedBox(height: 60,),
            child: BlocBuilder<SearcherCubit, SearcherState>(
              buildWhen: (a, b) => a.useMyDeco != b.useMyDeco,
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: false,
                      groupValue: state.useMyDeco,
                      onChanged: (val) => context.read<SearcherCubit>().useMyDeco(val ?? true),
                      title: const Text('Use all decos'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: state.useMyDeco,
                            onChanged: (val) => context.read<SearcherCubit>().useMyDeco(val ?? true),
                            title: const Text('Use my decos'),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => context.read<SearcherPageCubit>().updateScreen(SearcherPageState.editDecos),
                          color: HSLColor.fromColor(Colors.deepPurple).withSaturation(0.4).toColor(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text('Edit my deocs'),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          )
        ],
      )
  );
}

List<Widget> _makeSearcherOptions(BuildContext context) {
  return [
    _option(context, 'Edit Skills', SearcherPageState.editSkills, BlocBuilder<SearcherCubit, SearcherState>(
      buildWhen: (a, b) => !listEquals(a.skills, b.skills),
      builder: (context, state) {
        return _skillsPreview(context, state);
      },
    )),
    _decosOption(context)
  ];
}

Widget _skillTile(BuildContext context, ass.Stack<Skill> skill, bool mobile) {
  Widget tile = Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(8)),
    child: Row(
        children: [
          Expanded(
              flex: 66,
              child: Text(
                skill.value.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )),
          Text('Lv: ${skill.amount}'),
          if (skill.value.maxLevel > 1)
            Expanded(
              flex: 33,
              child: Slider(
                value: clampDouble(skill.amount.toDouble(), 1.0, skill.value.maxLevel.toDouble()),
                onChanged: (val) {
                  if (skill.amount != val.toInt()) {
                    context.read<SearcherCubit>().updateSkillLevel(skill.value, val.toInt());
                  }
                },
                min: 1.0,
                max: skill.value.maxLevel.toDouble(),
                divisions: skill.value.maxLevel - 1,
              ),
            )
          else
            Expanded(flex: 33, child: Container()),
          if (!mobile)
            IconButton(
                onPressed: () => context.read<SearcherCubit>().removeSkill(skill.value),
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red.shade700,
                ))
        ],
      )
  );
  if (mobile) {
    return Dismissible(
        key: Key(skill.value.name),
        onDismissed: (dir) => context.read<SearcherCubit>().removeSkill(skill.value),
        child: tile);
  }
  return tile;
}


class SearcherDesktop extends StatelessWidget {
  const SearcherDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: _makeSearcherOptions(context),
          ),
        ),
        const VerticalDivider(thickness: 4,),
        Expanded(
          child: BlocBuilder<SearcherPageCubit, SearcherPageState> (
              builder: (context, state) {
                switch (state) {
                  case SearcherPageState.editSkills: return const SkillEditor(doneButton: false);
                  case SearcherPageState.editDecos: return const DecoEditor();
                  case SearcherPageState.editArmorFilters: return const Placeholder();
                }
              }
          ),
        ),
        const Expanded(child: Placeholder())
      ],
    );
  }
}

abstract class _AbstractSearcherPageState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  Widget _optionsList(BuildContext context, SearcherState state, SkillSelectorState selectorState, double maxHeight) {
    if (!selectorState.shown) return const SizedBox.shrink();
    List<Widget> options = [];
    List<Skill> skills = List.of(All.skills);
    if (selectorState.searchValue.isEmpty) {
      if (state.skills.isNotEmpty) {
        skills = All.skills.where((skill) => !state.hasSkill(skill)).toList();
      }
    } else {
      skills = All.skills.where((skill) => skill.matchesSearch(selectorState.searchValue) && !state.hasSkill(skill)).toList();
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
      for (Skill skill in skills) {
        options.add(InkWell(
            onTap: () {
              context.read<SearcherCubit>().addSkill(skill);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                skill.name,
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

  List<Widget> _buildSkillList(BuildContext context, SearcherState state, bool mobile) {
    List<Widget> skills = [];
    /*_skills.sort((a, b) {
      return b.amount.compareTo(a.amount);
    });*/
    for (ass.Stack<Skill> skill in state.skills) {
      skills.add(_skillTile(context, skill, true));
    }
    return skills;
  }

  Widget _skillSelector(SearcherState state, double maxListHeight) {
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
                    context.read<SearcherCubit>().clearSkills();
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
                child: BlocBuilder<SearcherCubit, SearcherState>(
                  buildWhen: (a, b) => !listEquals(a.skills, b.skills),
                  builder: (context, state) {
                    return ListView(
                      children: _buildSkillList(context, state, true),
                    );
                  },
                )),
            _skillSelector(context
                .read<SearcherCubit>()
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

class DecoEditor extends StatefulWidget {
  const DecoEditor({super.key});

  @override
  State<DecoEditor> createState() => _DecoEditorState();
}

class _DecoEditorState extends State<DecoEditor> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
