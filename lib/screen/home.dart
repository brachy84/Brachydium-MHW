import 'package:brachydium_searcher/bloc/cubits.dart';
import 'package:brachydium_searcher/screen/armor_sets.dart';
import 'package:brachydium_searcher/screen/decoration.dart';
import 'package:brachydium_searcher/screen/dev/equipment.dart';
import 'package:brachydium_searcher/screen/searcher2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, required this.isHome});

  final bool isHome;

  Widget makeMenuCard(BuildContext context, String title, HomeState state,
      [Widget icon = const Icon(Icons.chevron_right)]) {
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
            const Center(
                child: Text(
              'Menu',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            )),
            makeMenuCard(context, 'Set Searcher', HomeState.setSearcher),
            const SizedBox(
              height: 8,
            ),
            makeMenuCard(context, 'My Decorations', HomeState.decorations),
            const SizedBox(
              height: 8,
            ),
            makeMenuCard(context, 'My Armor Sets', HomeState.armorSets),
            const SizedBox(
              height: 8,
            ),
            if (kDebugMode) makeMenuCard(context, 'Edit Armors', HomeState.devEditArmor)
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
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      switch (state) {
        case HomeState.setSearcher:
          return const SearcherMobile();
        case HomeState.decorations:
          return const Placeholder(); // TODO
        case HomeState.armorSets:
          return const ArmorSetsPageMobile(mobile: true);
        case HomeState.devEditArmor:
          return ArmorEditor();
      }
    });
  }
}

class HomePageDesktop2 extends StatelessWidget {
  const HomePageDesktop2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      switch (state) {
        case HomeState.setSearcher:
          return const SearcherDesktop();
        case HomeState.decorations:
          return const Placeholder(); // TODO
        case HomeState.armorSets:
          return const ArmorSetsPageMobile(mobile: false);
        case HomeState.devEditArmor:
          return ArmorEditor();
      }
    });
  }
}
