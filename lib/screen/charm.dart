
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubits.dart';
import '../data/equipment.dart';

class CharmEditorPage extends StatefulWidget {
  const CharmEditorPage({super.key});

  @override
  State<CharmEditorPage> createState() => _CharmEditorPageState();
}

class _CharmEditorPageState extends State<CharmEditorPage> {
  List<CharmFamily> charms = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _updateSearch(String s) {
    s = s.toLowerCase();
    charms.clear();
    for (CharmFamily charm in All.charmFamiliesList) {
      if (s.isEmpty || charm.first.localizedName.toLowerCase().contains(s)) {
        charms.add(charm);
      }
    }
    charms.sort((a, b) {
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
                  onPressed: () => setState(() => context.read<SearcherArgsCubit>().setCharmsToZero()),
                  child: Text('Set all Charms to zero'),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: MaterialButton(
                  height: 32,
                  color: Colors.blue.withAlpha(150),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () => setState(() => context.read<SearcherArgsCubit>().setCharmsToMax()),
                  child: Text('Set all Charms to max'),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: max(1, charms.length),
            prototypeItem: CharmTile(charm: All.charmFamilies.values.first),
            itemBuilder: (context, i) {
              if (charms.isEmpty) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No Charms Found'),
                );
              }
              return CharmTile(charm: charms[i]);
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
                hintText: 'Search Charm',
                hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                icon: const Icon(Icons.search)),
          ),
        )
      ],
    );
  }
}

const minus = Icon(Icons.remove);
const plus = Icon(Icons.add);

class CharmTile extends StatelessWidget {
  const CharmTile({super.key, required this.charm});

  final CharmFamily charm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white12),
      child: Row(
        children: [
          Text(charm.first.localizedName),
          Spacer(),
          FastButton(charm: charm, up: false),
          //IconButton(onPressed: () => context.read<SearcherArgsCubit>().updateDecoLevelBy(deco, -1), icon: minus),
          BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
            buildWhen: (prev, next) => prev.charms?[charm] != next.charms?[charm],
            builder: (context, state) {
              return Text(' ${state.charms?[charm] ?? charm.maxLevel} ');
            },
          ),
          FastButton(charm: charm, up: true)
          //IconButton(onPressed: () => context.read<SearcherArgsCubit>().updateDecoLevelBy(deco, 1), icon: plus)
        ],
      ),
    );
  }
}

class FastButton extends StatelessWidget {
  const FastButton({super.key, required this.charm, required this.up});

  final CharmFamily charm;
  final bool up;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => context.read<SearcherArgsCubit>().updateCharmLevelBy(charm, up ? 1 : -1),
      radius: 10,
      child: up ? plus : minus,
    );
  }
}
