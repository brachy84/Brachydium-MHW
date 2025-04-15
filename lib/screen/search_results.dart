import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

import '../bloc/cubits.dart';
import '../data/equipment.dart';
import '../data/set_finder.dart' as ass;

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SearchResultCubit, SearchResultState>(builder: (context, state) {
          if (!state.hasResult) {
            return const Center(
              child: Text(
                'No Results yet',
                style: TextStyle(fontSize: 24),
              ),
            );
          }
          // broadcast so we can listen here for total set amount and in list for the sets
          Stream<ArmorSet> armorSetStream = state.searchResult!.armorSetStream.stream.asBroadcastStream();
          int foundSets = 0;
          armorSetStream.listen((_) => foundSets++);
          int totalCombionations = state.searchResult!.totalArmorSets;
          return Column(children: [
            Container(
                height: 32,
                constraints: const BoxConstraints(minWidth: double.infinity),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white.withAlpha(40)),
                child: StreamBuilder<int>(
                    stream: state.searchResult!.processedArmorSets.stream,
                    builder: (context, snapshot1) {
                      int progress = snapshot1.hasData ? snapshot1.data! : 0;
                      return Stack(
                        children: [
                          if (totalCombionations > 0 && progress > 0)
                            FractionallySizedBox(
                              widthFactor: progress / totalCombionations,
                              child: Container(
                                height: 32,
                                constraints: const BoxConstraints(minWidth: double.infinity),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.red.shade800),
                              ),
                            ),
                          Center(
                            child: Text('$progress / $totalCombionations  -  $foundSets'),
                          )
                        ],
                      );
                    })),
            Expanded(
                child: Container(
                  child: ArmorSetList(armorSetStream: armorSetStream),
                ))
          ]);
        })
    );
  }


}

class ArmorSetList extends StatefulWidget {
  const ArmorSetList({super.key, required this.armorSetStream});

  final Stream<ArmorSet> armorSetStream;

  @override
  State<ArmorSetList> createState() => _ArmorSetListState();
}

class _ArmorSetListState extends State<ArmorSetList> {

  final List<ArmorSet> armorSets = [];

  @override
  void initState() {
    super.initState();
    widget.armorSetStream.listen((set) {
      setState(() {
        armorSets.add(set);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: armorSets.length,
        itemBuilder: (ctx, index) {
          return _buildArmorSetTile(context, armorSets[index]);
        });
  }

  Widget _buildArmorSetTile(BuildContext context, ArmorSet set) {
    String display =
        '${set.pieces[0].equipment.localizedName}, ${set.pieces[3].equipment.localizedName},\n${set.pieces[1].equipment
        .localizedName}, ${set.pieces[4].equipment.localizedName},\n${set.pieces[2].equipment.localizedName}, ${set.charm.localizedName}';
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MaterialButton(
        height: 32,
        color: Colors.white.withAlpha(40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(4),
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 750, maxHeight: 500, minWidth: 400, minHeight: 200),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: [
                                _equipment(context, EquipmentPiece(equipment: All.dummyWeapon, decorations: set.weaponDecos)),
                                _equipment(context, set.pieces[0]),
                                _equipment(context, set.pieces[1]),
                                _equipment(context, set.pieces[2]),
                                _equipment(context, set.pieces[3]),
                                _equipment(context, set.pieces[4]),
                                _charm(context, set.charm)
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
                                  padding: const EdgeInsets.all(8),
                                  child: ListView(
                                    children: _buildSkills(set),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Center(child: Text(display)),
      ),
    );
  }

  Widget _equipment(BuildContext context, EquipmentPiece eq) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 10, child: Text(eq.equipment.part.localizedName)),
          Expanded(flex: 15, child: Text(eq.equipment.localizedName)),
          Expanded(flex: 1, child: _slotSizes(eq.equipment)),
          Expanded(flex: 15, child: _decos(eq.equipment, eq.decorations))
        ],
      ),
    );
  }

  Widget _slotSizes(Equipment eq) {
    if (eq is SlottedEquipment) {
      var seq = eq as SlottedEquipment;
      TextStyle style = const TextStyle(fontSize: 12);
      return Column(
        children: [
          Text(
            seq.primarySlotSize == 0 ? '-' : seq.primarySlotSize.toString(),
            style: style,
          ),
          Text(
            seq.secondarySlotSize == 0 ? '-' : seq.secondarySlotSize.toString(),
            style: style,
          ),
          Text(
            seq.ternarySlotSize == 0 ? '-' : seq.ternarySlotSize.toString(),
            style: style,
          ),
        ],
      );
    }
    return const Text('-');
  }

  Widget _decos(Equipment eq, List<Deco?> decos) {
    TextStyle style = const TextStyle(fontSize: 12);
    return Column(
      children: [
        Text(decos[0] == null ? '-' : decos[0]!.localizedName, style: style),
        Text(decos[1] == null ? '-' : decos[1]!.localizedName, style: style),
        Text(decos[2] == null ? '-' : decos[2]!.localizedName, style: style),
      ],
    );
  }

  Widget _charm(BuildContext context, Charm charm) {
    return Container(
      height: 32,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
      child: Row(
        children: [
          Expanded(flex: 10, child: Text(charm.part.localizedName)),
          Expanded(flex: 15, child: Text(charm.localizedName)),
          const Spacer(
            flex: 1,
          ),
          const Spacer(
            flex: 15,
          )
        ],
      ),
    );
  }

  List<Widget> _buildSkills(ArmorSet armorSet) {
    return armorSet.calculateSkills(removeNonFullBonus: false, removeOverlevel: false).map((skill) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          skill.value.localize(skill.amount, capAtMax: false),
          style: TextStyle(color: skill.value.getColor(skill.amount)),
        ),
      );
    }).toList();
  }
}

