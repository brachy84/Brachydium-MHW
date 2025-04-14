
import 'package:flutter/material.dart';

import '../data/equipment.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  Stream<ArmorSet?>? armorSetStream;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Results', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
      ],
    );
  }
}
