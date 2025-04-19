import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubits.dart';
import '../data/equipment.dart';

class DataStream<T> {
  final StreamController<T> controller;
  Stream<T> _stream;
  final List<StreamSubscription<T>> _subscriptions = [];

  DataStream._(this.controller, this._stream);

  factory DataStream(StreamController<T> controller) {
    return DataStream._(controller, controller.stream);
  }

  void add(T data) {
    controller.add(data);
  }

  Future close() async {
    return controller.close();
  }

  //Stream<T> get stream => _stream;

  bool get isClosed => controller.isClosed;

  Future<StreamSubscription<T>?> listen(void Function(T)? onData) async {
    if (isClosed) return null;
    if (!_stream.isBroadcast) await cancelSubscriptions();
    return _stream.listen(onData);
  }

  bool get hasSubscriptions => _subscriptions.isNotEmpty;

  Future<void> cancelSubscriptions() async {
    for (var sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
  }

  void asBroadcastStream() {
    if (!_stream.isBroadcast) {
      cancelSubscriptions();
      _stream = _stream.asBroadcastStream();
    }
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DataStream && _stream == other._stream);
  }
}

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
          state.searchResult!.armorSetStream.asBroadcastStream();
          return Column(children: [
            ProgressBar(
                progressStream: state.searchResult!.processedArmorSets,
                armorSetStream: state.searchResult!.armorSetStream,
                totalCount: state.searchResult!.totalArmorSets),
            Expanded(
                child: Container(
              child: ArmorSetList(armorSetStream: state.searchResult!.armorSetStream),
            ))
          ]);
        }));
  }
}

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key, required this.progressStream, required this.armorSetStream, required this.totalCount});

  final int totalCount;
  final DataStream<int> progressStream;
  final DataStream<ArmorSet> armorSetStream;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  int progress = 0;
  int foundSets = 0;

  void _listenStream([bool resetData = true]) async {
    await widget.progressStream.cancelSubscriptions();
    await widget.armorSetStream.cancelSubscriptions();
    if (resetData) {
      progress = 0;
      foundSets = 0;
    }
    widget.progressStream.listen((p) {
      setState(() {
        progress = p;
      });
    });
    widget.armorSetStream.listen((_) {
      setState(() {
        foundSets++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listenStream();
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ensures that the armor set list is updated when a new search is happening
    _listenStream(
        widget.progressStream != oldWidget.progressStream || widget.armorSetStream != oldWidget.armorSetStream);
  }

  @override
  void reassemble() {
    super.reassemble();
    //_listenStream(false);
  }

  @override
  void dispose() {
    super.dispose();
    widget.armorSetStream.cancelSubscriptions();
    widget.progressStream.cancelSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32,
        constraints: const BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white.withAlpha(40)),
        child: Stack(
          children: [
            if (widget.totalCount > 0 && progress > 0)
              FractionallySizedBox(
                widthFactor: progress / widget.totalCount,
                child: Container(
                  height: 32,
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.red.shade800),
                ),
              ),
            Center(
              child: Text('$progress / ${widget.totalCount}  -  $foundSets'),
            )
          ],
        ));
  }
}

extension InsertSorted<T> on List<T> {
  // finds a position in the list so that the new list is sorted
  // assumes that before inserting the list is sorted
  // this is much faster than sorting after inserting
  void addSorted(T t, [int Function(T a, T b)? compare]) {
    int low = 0;
    int high = length;

    compare ??= (a, b) => (a as Comparable<T>).compareTo(b);

    // binary search index
    while (low < high) {
      int mid = (low + high) >> 1;
      if (compare(t, this[mid]) < 0) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }

    insert(low, t);
  }
}

class ArmorSetList extends StatefulWidget {
  const ArmorSetList({super.key, required this.armorSetStream});

  final DataStream<ArmorSet> armorSetStream;

  @override
  State<ArmorSetList> createState() => _ArmorSetListState();
}

class _ArmorSetListState extends State<ArmorSetList> {
  final List<ArmorSetProperties> armorSets = [];

  void _listenStream([bool resetData = true]) async {
    await widget.armorSetStream.cancelSubscriptions();
    if (resetData) {
      armorSets.clear();
    }
    widget.armorSetStream.listen((set) {
      setState(() {
        armorSets.addSorted(ArmorSetProperties(set), (a, b) => a.compareEmptyTotalWeightedSlots(b));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listenStream();
  }

  @override
  void didUpdateWidget(covariant ArmorSetList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ensures that the armor set list is updated when a new search is happening
    _listenStream(widget.armorSetStream != oldWidget.armorSetStream);
  }

  @override
  void reassemble() {
    super.reassemble();
    //_listenStream(false);
  }

  @override
  void dispose() {
    super.dispose();
    widget.armorSetStream.cancelSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: armorSets.length,
        prototypeItem: _buildArmorSetTile(context, ArmorSetProperties.dummy, 0),
        itemBuilder: (ctx, index) {
          return _buildArmorSetTile(context, armorSets[index], index);
        });
  }

  Widget _buildArmorSetTile(BuildContext context, ArmorSetProperties prop, int index) {
    ArmorSet set = prop.armorSet;
    List<String> display1 = [
      set.pieces[0].equipment.localizedName,
      set.pieces[1].equipment.localizedName,
      set.pieces[2].equipment.localizedName
    ];
    List<String> display2 = [
      set.pieces[3].equipment.localizedName,
      set.pieces[4].equipment.localizedName,
      set.charm.localizedName
    ];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          showDialog(context: context, builder: (ctx) => _armorSetDialog(ctx, set));
        },
        child: Container(
          //height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  '#${index + 1}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Column(
                children: display1.map((s) => Text(s)).toList(),
              ),
              Column(
                children: display2.map((s) => Text(s)).toList(),
              ),
              Spacer(
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Dialog _armorSetDialog(BuildContext context, ArmorSet set) {
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
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
