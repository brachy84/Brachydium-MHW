import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/screen/armor_sets.dart';
import 'package:brachys_armor_set_searcher/screen/decoration.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:brachys_armor_set_searcher/screen/searcher.dart';
import 'package:brachys_armor_set_searcher/screen/searcher2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, required this.isHome});

  final bool isHome;

  Widget makeMenuCard(BuildContext context, String title, HomeState state, [Widget icon = const Icon(Icons.chevron_right)]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          BlocProvider.of<HomeCubit>(context).updateScreen(state);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)), icon],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Center(child: Text('Menu', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),)),
            makeMenuCard(context, 'Set Searcher', HomeState.setSearcher),
            const SizedBox(
              height: 8,
            ),
            makeMenuCard(context, 'My Decorations', HomeState.decorations),
            const SizedBox(
              height: 8,
            ),
            makeMenuCard(context, 'My Armor Sets', HomeState.armorSets)
          ],
        ),
      ),
    );
  }
}

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeState.setSearcher: return const SearcherMobilePage();
            case HomeState.decorations: return const Placeholder(); // TODO
            case HomeState.armorSets: return const Placeholder();
          }
        }
    );
  }
}

class HomePageDesktop2 extends StatelessWidget {
  const HomePageDesktop2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeState.setSearcher: return const SearcherDesktop();
            case HomeState.decorations: return const Placeholder(); // TODO
            case HomeState.armorSets: return const Placeholder();
          }
        }
    );
  }
}


abstract class _HomePageState<T extends StatefulWidget> extends State<T> {}



Widget? _currentDesktopWidget;
int _activeDesktop = -1;

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {

  Widget makeMenuCard(BuildContext context, int index, String title, Widget page, [Widget icon = const Icon(Icons.chevron_right)]) {
    if (_currentDesktopWidget == null) {
      _currentDesktopWidget = page;
      _activeDesktop = index;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            _currentDesktopWidget = page;
            _activeDesktop = index;
          });
        },
        elevation: _activeDesktop == index ? 5 : 0,
        color: _activeDesktop == index ? Colors.deepPurple.shade600 : Colors.white.withAlpha(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)), icon],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          constraints: const BoxConstraints.tightFor(width: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              makeMenuCard(context, 0, 'Set Searcher', const SearcherDesktopPage()),
              const SizedBox(
                height: 8,
              ),
              makeMenuCard(context, 1, 'My Decorations', const DecoPageMobile()),
              const SizedBox(
                height: 8,
              ),
              makeMenuCard(context, 2, 'My Armor Sets', const ArmorSetsPageMobile())
            ],
          ),
        ),
        const VerticalDivider(thickness: 4,),
        Expanded(child: _currentDesktopWidget ?? const SizedBox(width: 1,))
      ],
    );
  }
}
