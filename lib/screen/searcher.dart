import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart' as ass;
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

final List<ass.Stack<Skill>> _skills = [];
final List<ass.ArmorFilter> _armorFilters = [];

bool _hasSkill(Skill skill) {
  return _skills.any((s) => s.value == skill);
}

bool _useMyDecos = true;


/*int _getMaxLevelFor(Skill skill) {
  for (ass.Stack<Skill> skill1 in _skills) {

  }
}*/

Widget _option(BuildContext context, String title, Widget page, Widget child, StateSetter setState) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withAlpha(20),
      onPressed: () {
        Navigator.of(context)
            .push<void>(MaterialPageRoute(builder: (context) => SimplePage(body: page, title: title)))
            .then((_) => setState(() {}));
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

Widget _skillsPreview(BuildContext context) {
  if (_skills.isEmpty) {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text('None selected'),
    );
  }
  List<Widget> skills = _skills.map((skill) => _makeSkillChip("${skill.value.name} ${skill.amount}")).toList();
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    alignment: WrapAlignment.spaceEvenly,
    children: skills,
  );
}

Widget _decosOption(BuildContext context, StateSetter setState) {
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
            child: Column(
              children: [
                RadioListTile(
                  value: false,
                  groupValue: _useMyDecos,
                  onChanged: (val) => setState(() => _useMyDecos = val ?? true),
                  title: const Text('Use all decos'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: true,
                        groupValue: _useMyDecos,
                        onChanged: (val) => setState(() => _useMyDecos = val ?? true),
                        title: const Text('Use my decos'),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // TODO open edit decos screen
                      },
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
            ),
          )
        ],
      )
  );
}

List<Widget> _makeSearcherOptions(BuildContext context, StateSetter setState) {
  return [
    _option(context, 'Edit Skills', const SkillEditor(), _skillsPreview(context), setState),
    _decosOption(context, setState)
  ];
}

abstract class _AbstractSearcherPageState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showOptions = false;
  String searchValue = '';
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  Widget _skillTile(ass.Stack<Skill> skill, bool mobile) {
    Widget tile = Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(8)),
      child: StatefulBuilder(builder: (context, innerSetState) {
        // only rebuild this tile
        return Row(
          children: [
            Expanded(
                flex: 66,
                child: Text(
                  skill.value.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            if (skill.value.cappedMaxLevel > 1) ...[
              Text('Lv: ${skill.amount}'),
              Expanded(
                flex: 33,
                child: Slider(
                  value: clampDouble(skill.amount.toDouble(), 1.0, skill.value.cappedMaxLevel.toDouble()),
                  onChanged: (val) {
                    innerSetState(() {
                      skill.amount = val.toInt();
                    });
                  },
                  min: 1.0,
                  max: skill.value.cappedMaxLevel.toDouble(),
                  divisions: skill.value.cappedMaxLevel - 1,
                ),
              ),
            ],
            if (!mobile)
              IconButton(
                  onPressed: () {
                    setState(() {
                      _skills.removeAt(_skills.indexWhere((skill1) => skill1.value == skill.value));
                    });
                  },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red.shade700,
                  ))
          ],
        );
      }),
    );
    if (mobile) {
      return Dismissible(
          key: Key(skill.value.name),
          onDismissed: (dir) {
            setState(() {
              _skills.removeAt(_skills.indexWhere((skill1) => skill1.value == skill.value));
            });
          },
          child: tile);
    }
    return tile;
  }

  List<Widget> _buildSkillList(BuildContext context, bool mobile) {
    List<Widget> skills = [];
    /*_skills.sort((a, b) {
      return b.amount.compareTo(a.amount);
    });*/
    for (ass.Stack<Skill> skill in _skills) {
      skills.add(_skillTile(skill, true));
    }
    return skills;
  }

  Widget _optionsList(double maxHeight) {
    if (!showOptions) return const SizedBox.shrink();
    List<Widget> options = [];
    List<Skill> skills = List.of(All.skills);
    if (searchValue.isEmpty) {
      if (_skills.isNotEmpty) {
        skills = All.skills.where((skill) => !_hasSkill(skill)).toList();
      }
    } else {
      skills = All.skills.where((skill) => skill.matchesSearch(searchValue) && !_hasSkill(skill)).toList();
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
      skills.sort((a, b) => a.compareForSearch(b, searchValue));
      for (Skill skill in skills) {
        options.add(InkWell(
            onTap: () {
              setState(() {
                _skills.add(ass.Stack(value: skill, amount: skill.maxLevel));
              });
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
          _hideOptions();
        },
        child: ListView(
          shrinkWrap: true,
          children: options,
        ),
      ),
    );
  }

  void _showOptions() {
    if (showOptions) return;
    setState(() {
      showOptions = true;
      _animationController!.forward(from: 0);
    });
  }

  void _hideOptions() {
    if (!showOptions) return;
    setState(() {
      showOptions = false;
      _animationController!.value = 0;
    });
  }

  void _updateOptions(String value) {
    setState(() {
      showOptions = true;
      searchValue = value;
      _animationController!.forward();
    });
  }

  Widget _skillSelector(double maxListHeight) {
    //return AutoCompleteField(link: _link);
    return PortalTarget(
        portalFollower: Material(
          color: Colors.black.withAlpha(0),
          child: _optionsList(maxListHeight),
        ),
        visible: showOptions,
        anchor: const Aligned(
          follower: Alignment.bottomLeft,
          target: Alignment.topLeft,
          portal: Alignment.topCenter,
          //alignToPortal: AxisFlag(y: true, x: true)
        ),
        child: TapRegion(
          groupId: "skill_selector",
          onTapOutside: (event) {
            _hideOptions();
          },
          child: TextField(
            controller: _controller,
            onTap: _showOptions,
            onChanged: (val) => _updateOptions(val),
            onSubmitted: (val) => _hideOptions(),
            onEditingComplete: _hideOptions,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                hintText: 'Add Skill',
                hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                icon: const Icon(Icons.search)),
          ),
        ));
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

class SearcherDesktopPage extends StatelessWidget {
  const SearcherDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearcherPageCubit>(
        create: (_) => SearcherPageCubit(),
      child: Row(
        children: [
          Column(
            children: [],
          ),
          BlocBuilder<SearcherPageCubit, SearcherPageState>(
            builder: (BuildContext context, state) {
              switch (state) {
                case SearcherPageState.editSkills: return const Placeholder();
                case SearcherPageState.editDecos: return const Placeholder();
                case SearcherPageState.editArmorFilters: return const Placeholder();
              }
            },
          ),
        ],
      ),
    );
  }
}


/*class SearcherDesktopPage extends StatefulWidget {
  const SearcherDesktopPage({super.key});

  @override
  State<SearcherDesktopPage> createState() => _SearcherDesktopPageState();
}

class _SearcherDesktopPageState extends _AbstractSearcherPageState<SearcherDesktopPage> {
  Widget buildSkillSelector(BuildContext context) {
    return Container();
  }

  @override
  Widget _searchButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 60),
      child: MaterialButton(
        onPressed: () {},
        color: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Text(
          "Search",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Portal(
              child: Column(
                children: [
                  const Text(
                    "Skills",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const Divider(),
                  Expanded(
                      child: ListView(
                        children: _buildSkillList(context, false),
                      )),
                  _skillSelector(400),
                  _searchButton()
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          const Expanded(
              child: Column(
                children: [
                  Text('Result', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  const Divider(),
                  // TODO progress bar
                ],
              ))
        ],
      ),
    );
  }
}*/

class SearcherTabletPage extends StatefulWidget {
  const SearcherTabletPage({super.key});

  @override
  State<SearcherTabletPage> createState() => _SearcherTabletPageState();
}

class _SearcherTabletPageState extends _AbstractSearcherPageState<SearcherTabletPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text('Tablet'),
      ),
    );
  }
}

class SearcherMobilePage extends StatefulWidget {
  const SearcherMobilePage({super.key});

  @override
  State<SearcherMobilePage> createState() => _SearcherMobilePageState();
}

class _SearcherMobilePageState extends _AbstractSearcherPageState<SearcherMobilePage> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: _makeSearcherOptions(context, setState),
      ),
    );
  }
}

class SkillEditor extends StatefulWidget {
  const SkillEditor({super.key});

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
                    setState(() {
                      _skills.clear();
                    });
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
                child: ListView(
                  children: _buildSkillList(context, true),
                )),
            _skillSelector(250),
            const SizedBox(
              height: 8,
            ),
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

