import 'dart:math';

import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/material.dart';

class DecoPageMobile extends StatefulWidget {
  const DecoPageMobile({super.key});

  @override
  State<DecoPageMobile> createState() => _DecoPageMobileState();
}

class _DecoPageMobileState extends State<DecoPageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DecoEditor extends StatefulWidget {
  const DecoEditor({super.key});

  @override
  State<DecoEditor> createState() => _DecoEditorState();
}

class _DecoEditorState extends State<DecoEditor> {
  List<Deco> decos = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _updateSearch(String s) {
    s = s.toLowerCase();
    decos.clear();
    for (Deco deco in All.decos) {
      if (s.isEmpty || deco.localizedName.toLowerCase().contains(s)) {
        decos.add(deco);
      }
    }
    decos.sort((a, b) {
      int i = a.category.index.compareTo(b.category.index);
      if (i != 0) return i;
      return a.name.compareTo(b.name);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  height: 32,
                  color: Colors.red.shade700.withAlpha(150),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () => setState(() => context.read<SearcherArgsCubit>().setDecosToZero()),
                  child: Text('Set all Decos to zero'),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: MaterialButton(
                  height: 32,
                  color: Colors.blue.withAlpha(150),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () => setState(() => context.read<SearcherArgsCubit>().setDecosToMax()),
                  child: Text('Set all Decos to max'),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: max(1, decos.length),
            prototypeItem: DecoTile(deco: All.decos.first),
            itemBuilder: (context, i) {
              if (decos.isEmpty) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No Decos Found'),
                );
              }
              return DecoTile(deco: decos[i]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textEditingController,
            onChanged: (v) => setState(() => _updateSearch(v)),
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                hintText: 'Search Decoration',
                hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                icon: const Icon(Icons.search)),
          ),
        )
      ],
    );
  }
}

class DecoTile extends StatelessWidget {
  const DecoTile({super.key, required this.deco});

  final Deco deco;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: (deco.category == SkillCategory.weapon ? Colors.red.shade300 : Colors.orange.shade300)
              .withAlpha(100)),
      child: Row(
        children: [
          Text(deco.localizedName),
          Spacer(),
          IconButton(onPressed: () => context.read<SearcherArgsCubit>().updateDecoLevelBy(deco, -1), icon: Icon(Icons.remove)),
          BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
            buildWhen: (prev, next) => prev.decos?[deco] != next.decos?[deco],
            builder: (context, state) {
              return Text(' ${state.decos?[deco] ?? deco.maxDecoAmount} ');
            },
          ),
          IconButton(onPressed: () => context.read<SearcherArgsCubit>().updateDecoLevelBy(deco, 1), icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
