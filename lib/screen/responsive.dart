import 'package:brachydium_searcher/data/equipment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const int _mobileW = 600;
const int _tabletW = 1280;

class SimplePage extends StatelessWidget {
  const SimplePage({super.key, required this.body, required this.title, this.drawer});

  final String title;
  final Widget body;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          if (kDebugMode) IconButton(onPressed: () => All.saveData(), icon: const Icon(Icons.save)),
          const Icon(Icons.settings)
        ],
      ),
      drawer: drawer,
      body: body,
    );
  }
}

class ResponsivePage extends StatelessWidget {

  static bool isMobile(double width) {
    return width <= _mobileW;
  }

  static bool isTablet(double width) {
    return width > _mobileW && width <= _tabletW;
  }

  static bool isDesktop(double width) {
    return width > _tabletW;
  }

  const ResponsivePage(
      {super.key, required this.mobile, required this.tablet, required this.desktop, required this.title, this.drawer});

  final String title;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          if (kDebugMode) IconButton(onPressed: () => All.saveData(), icon: const Icon(Icons.save)),
          const Icon(Icons.settings)
        ],
      ),
      drawer: drawer,
      body: LayoutBuilder(builder: (context, constraints) {
        if (isMobile(constraints.maxWidth)) {
          return mobile;
        }
        if (isTablet(constraints.maxWidth)) {
          return tablet;
        }
        return desktop;
      }),
    );
  }
}
