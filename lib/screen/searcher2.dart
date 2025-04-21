import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart' as ass;
import 'package:brachys_armor_set_searcher/screen/charm.dart';
import 'package:brachys_armor_set_searcher/screen/decoration.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:brachys_armor_set_searcher/screen/search_results.dart';
import 'package:brachys_armor_set_searcher/screen/skill_editor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget _option(BuildContext context, String title, SearcherPageState pageState, Widget child, bool mobile) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withAlpha(20),
      onPressed: () {
        _updateScreen(context, pageState, mobile);
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
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.deepPurple.shade600),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    ),
  );
}

Widget _skillsPreview(BuildContext context, SearcherArgsState state) {
  if (state.skills.isEmpty) {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text('None selected'),
    );
  }
  List<Widget> skills = state.skills
      .map((skill) => _makeSkillChip("${skill.value.localizedName} ${skill.value.getActualLevel(skill.level)}"))
      .toList();
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    alignment: WrapAlignment.spaceEvenly,
    children: skills,
  );
}

Widget _decosOption(BuildContext context, bool mobile) {
  return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(20)),
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
            child: BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
              buildWhen: (a, b) => (a.decos == null) != (b.decos == null),
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: false,
                      groupValue: state.decos != null,
                      onChanged: (val) => context.read<SearcherArgsCubit>().useMyDeco(val ?? true),
                      title: const Text('Use all decos'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: state.decos != null,
                            onChanged: (val) => context.read<SearcherArgsCubit>().useMyDeco(val ?? true),
                            title: const Text('Use my decos'),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => _updateScreen(context, SearcherPageState.editDecos, mobile),
                          color: HSLColor.fromColor(Colors.deepPurple).withSaturation(0.4).toColor(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4, top: 8, bottom: 8),
                            child: Row(
                              children: [Text('Edit my deocs'), Icon(Icons.chevron_right)],
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
      ));
}

Widget _charmsOption(BuildContext context, bool mobile) {
  return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Charms',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(30)),
            margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: double.infinity),
            //child: SizedBox(height: 60,),
            child: BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
              buildWhen: (a, b) => (a.charms == null) != (b.charms == null),
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: false,
                      groupValue: state.charms != null,
                      onChanged: (val) => context.read<SearcherArgsCubit>().useMyCharms(val ?? true),
                      title: const Text('Use all charms'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: state.charms != null,
                            onChanged: (val) => context.read<SearcherArgsCubit>().useMyCharms(val ?? true),
                            title: const Text('Use my charms'),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => _updateScreen(context, SearcherPageState.editCharms, mobile),
                          color: HSLColor.fromColor(Colors.deepPurple).withSaturation(0.4).toColor(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4, top: 8, bottom: 8),
                            child: Row(
                              children: [Text('Edit my charms'), Icon(Icons.chevron_right)],
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
      ));
}

List<Widget> _makeSearcherOptions(BuildContext context, bool mobile) {
  return [
    _option(
        context,
        'Edit Skills',
        SearcherPageState.editSkills,
        BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
          buildWhen: (a, b) => !listEquals(a.skills, b.skills),
          builder: (context, state) {
            return _skillsPreview(context, state);
          },
        ),
        mobile),
    _decosOption(context, mobile),
    _charmsOption(context, mobile),
    if (mobile)
      BlocBuilder<SearchResultCubit, SearchResultState>(
        builder: (context, state) {
          if (state.hasResult) {
            return _option(context, 'Results', SearcherPageState.results,
                state.searching ? Text('Searching') : Text('Done'), true);
          }
          return SizedBox.shrink();
        },
      )
  ];
}

void _updateScreen(BuildContext context, SearcherPageState state, bool mobile) {
  if (!mobile) {
    context.read<SearcherPageCubit>().updateScreen(state);
    return;
  }
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
    switch (state) {
      case SearcherPageState.editSkills:
        return SimplePage(body: const SkillEditor(doneButton: true), title: 'Skill Editor');
      case SearcherPageState.editArmorFilters:
        return SimplePage(body: Placeholder(), title: 'Armor filter Editor');
      case SearcherPageState.editDecos:
        return SimplePage(body: DecoEditor(), title: 'Deco Editor');
      case SearcherPageState.editCharms:
        return SimplePage(body: CharmEditorPage(), title: 'Charm Editor');
      case SearcherPageState.results:
        return SimplePage(
            body: SearchResultPage(
              mobile: true,
            ),
            title: 'Search Results');
    }
  }));
}

Widget _makeSearchButton(String text, Color color, void Function() callback) {
  return MaterialButton(
    onPressed: callback,
    color: color,
    minWidth: double.infinity,
    height: 64,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Text(
      text,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    ),
  );
}

Widget makeSearchStartButton(BuildContext context, bool navigate) {
  return _makeSearchButton('Start Search', Colors.green, () {
    context.read<SearchResultCubit>().startSearch(context
        .read<SearcherArgsCubit>()
        .state);
    if (navigate) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) =>
              SimplePage(
                  body: SearchResultPage(
                    mobile: true,
                  ),
                  title: 'Search Results')));
    }
  });
}

Widget makeSearchCancelButton() {
  return _makeSearchButton('Cancel Search', Colors.red.shade700, () => ass.SearchManager.cancelArmorSearch());
}

Widget makeSearchRestartButton(BuildContext context, bool navigate) {
  return _makeSearchButton('Restart Search', Colors.blue, () {
    context.read<SearchResultCubit>().startSearch(context
        .read<SearcherArgsCubit>()
        .state);
    if (navigate) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) =>
              SimplePage(
                  body: SearchResultPage(
                    mobile: true,
                  ),
                  title: 'Search Results')));
    }
  });
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
          child: ListView(children: [
            ..._makeSearcherOptions(context, false),
            const Spacer(),
            BlocBuilder<SearchResultCubit, SearchResultState>(
              builder: (context, state) {
                if (state.searching) {
                  return makeSearchCancelButton();
                } else {
                  return state.hasResult ? makeSearchRestartButton(context, false) : makeSearchStartButton(context, false);
                }
              },
            )
          ]),
        ),
        const VerticalDivider(
          thickness: 4,
        ),
        Expanded(
          child: BlocBuilder<SearcherPageCubit, SearcherPageState>(builder: (context, state) {
            switch (state) {
              case SearcherPageState.results:
              case SearcherPageState.editSkills:
                return const SkillEditor(doneButton: false);
              case SearcherPageState.editDecos:
                return const DecoEditor();
              case SearcherPageState.editCharms:
                return const CharmEditorPage();
              case SearcherPageState.editArmorFilters:
                return const Placeholder();
            }
          }),
        ),
        Expanded(child: SearchResultPage(mobile: false))
      ],
    );
  }
}

class SearcherMobile extends StatelessWidget {
  const SearcherMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(8),
      child: ListView(children: [
        ..._makeSearcherOptions(context, true),
        const Spacer(),
        BlocBuilder<SearchResultCubit, SearchResultState>(
          builder: (context, state) {
            if (state.searching) {
              return makeSearchCancelButton();
            } else {
              return state.hasResult ? makeSearchRestartButton(context, true) : makeSearchStartButton(context, true);
            }
          },
        )
      ]),
    );
  }
}
