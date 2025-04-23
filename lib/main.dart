import 'dart:io';

import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/util.dart';
import 'package:brachys_armor_set_searcher/screen/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'data/equipment.dart';
import 'data/profile.dart';
import 'data/set_finder.dart';
import 'screen/home.dart';

const String appTitle = 'Brachy\'s Armor Set Searcher';
const String appTitleShort = 'Brachy\'s ASS';

void main() async {
  // init flutter
  WidgetsFlutterBinding.ensureInitialized();
  log.info('Threads: ${Platform.numberOfProcessors}');
  // init armor data
  await All.init(); // total data size (armor, deco, charm, skill) around 140 KB
  await SearchManager.init();
  await Profile.init();
  //testSearch();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()),
          BlocProvider(create: (_) => SearcherArgsCubit()),
          BlocProvider(create: (_) => SearcherPageCubit()),
          BlocProvider(create: (_) => SkillSelectorCubit()),
          BlocProvider(create: (_) => SearchResultCubit()),
        ],
        child: MaterialApp(
          title: appTitleShort,
          theme: ThemeData.dark(useMaterial3: true),
          home: const ResponsivePage(
              mobile: HomePageMobile(),
              tablet: HomePageDesktop2(),
              desktop: HomePageDesktop2(),
              title: appTitle,
              drawer: Drawer(
                child: HomeDrawer(isHome: true),
              )),
        ));
  }
}
