
import 'package:flutter/material.dart';

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
        actions: const [Icon(Icons.settings)],
      ),
      drawer: drawer,
      body: body,
    );
  }
}

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key, required this.mobile, required this.tablet, required this.desktop, required this.title, this.drawer});

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
        actions: const [Icon(Icons.settings)],
      ),
      drawer: drawer,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return mobile;
        }
        if (constraints.maxWidth <= 1280) {
          return tablet;
        }
        return desktop;
      }),
    );
  }
}
