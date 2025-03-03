import 'dart:io';

import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:brachys_armor_set_searcher/screen/dev/equipment.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:brachys_armor_set_searcher/screen/searcher.dart' hide SkillEditor;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'screen/home.dart';

void log(Object msg) {
  if (true) {
    print(msg);
  }
}

bool _skillEditMode = true;

const String appTitle = 'Brachy\'s Armor Set Searcher';
const String appTitleShort = 'Brachy\'s ASS';

void main() async {
  // init flutter
  WidgetsFlutterBinding.ensureInitialized();
  // init armor data
  await All.init();
  // init window size
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(appTitle);
    //setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(340, 600));
  }
  // run app
  runApp(const BrachysArmorSetSearcherApp());
}

class BrachysArmorSetSearcherApp extends StatelessWidget {
  const BrachysArmorSetSearcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitleShort,
      theme: ThemeData.dark(useMaterial3: true),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomeCubit()),
            BlocProvider(create: (_) => SearcherCubit()),
            BlocProvider(create: (_) => SearcherPageCubit()),
            BlocProvider(create: (_) => SkillSelectorCubit())
          ],
          child: const ResponsivePage(
              mobile: HomePageMobile(),
              tablet: HomePageDesktop2(),
              desktop: HomePageDesktop2(),
              title: appTitle,
              drawer: Drawer(child: HomeDrawer(isHome: true),))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: const [Icon(Icons.settings)],
      ),
      body: Container(),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const ResponsivePage(
                                title: 'Set Searcher',
                                desktop: SearcherDesktopPage(),
                                tablet: SearcherTabletPage(),
                                mobile: SearcherMobilePage(),
                              ))),
                  child: const Text('Set Searcher')),
            ),
            if (_skillEditMode) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (ctx) => const SimplePage(title: 'Skill Editor', body: SkillEditor()))),
                    child: const Text('Skill Editor')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (ctx) => const SimplePage(title: 'Armor Editor', body: ArmorEditor()))),
                    child: const Text('Armor Editor')),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
