import 'package:brachys_armor_set_searcher/screen/armor_sets.dart';
import 'package:brachys_armor_set_searcher/screen/decoration.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:brachys_armor_set_searcher/screen/searcher.dart';
import 'package:flutter/material.dart';

abstract class _HomePageState<T extends StatefulWidget> extends State<T> {}

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends _HomePageState<HomePageMobile> {
  Widget makeMenuCard(String title, Widget page, [Widget icon = const Icon(Icons.chevron_right)]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SimplePage(title: title, body: page)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)), icon],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          makeMenuCard('Set Searcher', const SearcherMobilePage()),
          const SizedBox(
            height: 8,
          ),
          makeMenuCard('My Decorations', const DecoPageMobile()),
          const SizedBox(
            height: 8,
          ),
          makeMenuCard('My Armor Sets', const ArmorSetsPageMobile())
        ],
      ),
    );
  }
}

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
