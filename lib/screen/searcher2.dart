import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart' as ass;
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
      .map((skill) => _makeSkillChip("${skill.value.localizedName} ${skill.value.getActualLevel(skill.amount)}"))
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
              buildWhen: (a, b) => a.useMyDeco != b.useMyDeco,
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: false,
                      groupValue: state.useMyDeco,
                      onChanged: (val) => context.read<SearcherArgsCubit>().useMyDeco(val ?? true),
                      title: const Text('Use all decos'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: state.useMyDeco,
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
      case SearcherPageState.results:
        return SimplePage(
            body: SearchResultPage(
              mobile: true,
            ),
            title: 'Search Results');
    }
  }));
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
          child: Column(children: [
            ..._makeSearcherOptions(context, false),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: MaterialButton(
                onPressed: () {
                  ass.SearchManager.cancelArmorSearch();
                },
                color: Colors.red.shade700,
                minWidth: double.infinity,
                height: 64,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  'Cancel Search',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                context.read<SearchResultCubit>().startSearch(context
                    .read<SearcherArgsCubit>()
                    .state);
              },
              color: Colors.green,
              minWidth: double.infinity,
              height: 64,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: const Text(
                'Start Search',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
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
      child: Column(children: [
        ..._makeSearcherOptions(context, true),
        const Spacer(),
        BlocBuilder<SearchResultCubit, SearchResultState>(
          builder: (context, state) {
            if (state.searching) {
              return MaterialButton(
                onPressed: () {
                  ass.SearchManager.cancelArmorSearch();
                },
                color: Colors.red.shade700,
                minWidth: double.infinity,
                height: 64,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  'Cancel Search',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              );
            } else {
              return MaterialButton(
                onPressed: () {
                  context.read<SearchResultCubit>().startSearch(context
                      .read<SearcherArgsCubit>()
                      .state);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          SimplePage(
                              body: SearchResultPage(
                                mobile: true,
                              ),
                              title: 'Search Results')));
                },
                color: state.hasResult ? Colors.blue.shade700 : Colors.green,
                minWidth: double.infinity,
                height: 64,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Text(
                  state.hasResult ? 'Restart Search' : 'Start Search',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              );
            }
          },
        )
      ]),
    );
  }
}
