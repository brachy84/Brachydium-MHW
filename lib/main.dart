import 'dart:io';

import 'package:brachydium_searcher/bloc/cubits.dart';
import 'package:brachydium_searcher/data/util.dart';
import 'package:brachydium_searcher/screen/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:window_size/window_size.dart';

import 'data/equipment.dart';
import 'data/profile.dart';
import 'data/set_finder.dart';
import 'screen/home.dart';

const String appTitle = 'Brachydium Searcher';
const String appTitleShort = appTitle;

PackageInfo? _packageInfo;

PackageInfo get packageInfo => _packageInfo!;

bool? _portableExe;

bool get isPortableExe {
  _portableExe ??= Platform.isWindows & !File('installed.flag').existsSync();
  return _portableExe!;
}

const appcastURL = 'https://raw.githubusercontent.com/brachy84/BrachydiumSearcher/refs/heads/wilds/update/appcast.xml';
final upgrader = Upgrader(
  storeController: UpgraderStoreController(
    onAndroid: () => UpgraderAppcastStore(appcastURL: appcastURL),
    onWindows: () => UpgraderAppcastStore(appcastURL: appcastURL),
  ),
);

void main() async {
  // init flutter
  WidgetsFlutterBinding.ensureInitialized();
  log.info('Threads: ${Platform.numberOfProcessors}');
  // init armor data
  _packageInfo = await PackageInfo.fromPlatform();
  log.info("App version ${packageInfo.version}");
  await All.init(); // total data size (armor, deco, charm, skill) around 140 KB
  All.saveAll();
  //await All.checkWebUpdate("tu2_and_tu3");
  /*await SearchManager.init();
  await Profile.init();
  //testSearch();
  // init window size
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle(appTitle);
    //setWindowMaxSize(const Size(max_width, max_height));
    setWindowMinSize(const Size(340, 600));
  }
  // run app
  runApp(const BrachysArmorSetSearcherApp());*/
}

class BrachysArmorSetSearcherApp extends StatelessWidget {
  const BrachysArmorSetSearcherApp({super.key});

  @override
  Widget build(BuildContext context) {
      Widget home = ResponsivePage(
        mobile: HomePageMobile(),
        tablet: HomePageDesktop2(),
        desktop: HomePageDesktop2(),
        title: '$appTitle ${packageInfo.version}',
        drawer: Drawer(
          child: HomeDrawer(isHome: true),
        ));

    if (!isPortableExe) {
      // auto updates for portable zips is more complex
      home = UpgradeAlert(
        upgrader: upgrader,
        child: home,
      );
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()),
          BlocProvider(create: (_) => SearcherArgsCubit()),
          BlocProvider(create: (_) => SearcherPageCubit()),
          BlocProvider(create: (_) => SkillSelectorCubit()),
          BlocProvider(create: (_) => SearchResultCubit()),
          BlocProvider(create: (_) => ArmorSetCubit()),
        ],
        child: MaterialApp(
          title: appTitleShort,
          theme: ThemeData.dark(useMaterial3: true),
          home: home,
        ));
  }
}
