import 'dart:async';

import 'package:brachydium_searcher/data/util.dart';
import 'package:brachydium_searcher/screen/searcher2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubits.dart';
import '../data/equipment.dart';
import '../data/set_finder.dart' as ass;
import 'armor_sets.dart';

class DataStream<T> {
  final StreamController<T> controller;
  Stream<T> _stream;
  final List<StreamSubscription<T>> _subscriptions = [];

  DataStream._(this.controller, this._stream);

  factory DataStream(StreamController<T> controller) {
    var stream = DataStream._(controller, controller.stream);
    return stream;
  }

  void add(T data) {
    controller.add(data);
  }

  Future close() async {
    return controller.close();
  }

  bool get isClosed => controller.isClosed;

  StreamSubscription<T>? listen(void Function(T)? onData) {
    if (isClosed) return null;
    var sub = _stream.listen(onData);
    _subscriptions.add(sub);
    log.info('Adding stream listener');
    return sub;
  }

  bool get hasSubscriptions => _subscriptions.isNotEmpty;
}

class Observable {
  void Function()? observe;

  notify() {
    if (observe != null) {
      observe!();
    }
  }
}

ass.SearchResult? result;
int _progress = 0;
List<ArmorSetProperties> _foundSets = [];

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key, required this.mobile});

  final bool mobile;
  final Observable progressObservable = Observable();
  final Observable setsObservable = Observable();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SearchResultCubit, SearchResultState>(
          builder: (context, state) {
            _foundSets.sort((a, b) => state.sortFunction.compare(a, b));
            if (result != state.searchResult) {
              _foundSets.clear();
              _progress = 0;
              result = state.searchResult;
              if (result != null) {
                result!.armorSetStream.listen((d) {
                  d
                      .map((set) => ArmorSetProperties(set))
                      .forEach((set) => _foundSets.addSorted(set, (a, b) => state.sortFunction.compare(a, b)));
                  setsObservable.notify();
                });
                result!.processedArmorSets.listen((d) {
                  _progress = d;
                  progressObservable.notify();
                });
              }
            }
            if (!state.hasResult) {
              return const Center(
                child: Text(
                  'No Results yet',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }
            // broadcast so we can listen here for total set amount and in list for the sets
            return Column(children: [
              ProgressBar(observable: progressObservable, totalCount: state.searchResult!.totalArmorSets),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: MaterialButton(
                  height: 32,
                  minWidth: double.infinity,
                  color: Colors.deepPurple.shade500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    context.read<SearchResultCubit>().cycleSortFunction();
                  },
                  child: Text('Sort armor sets ${state.sortFunction.name}'),
                ),
              ),
              Expanded(
                  child: ArmorSetList(
                observable: setsObservable,
                mobile: mobile,
              )),
              if (mobile)
                if (state.searching) makeSearchCancelButton() else makeSearchRestartButton(context, false)
            ]);
          },
        ));
  }
}

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key, required this.observable, required this.totalCount});

  final int totalCount;
  final Observable observable;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  void _listenStream() async {
    widget.observable.observe = () => setState(() {});
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
    _listenStream();
  }

  @override
  void reassemble() {
    super.reassemble();
    //_listenStream(false);
  }

  @override
  void dispose() {
    super.dispose();
    widget.observable.observe = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 24,
        constraints: const BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white.withAlpha(40)),
        child: Stack(
          children: [
            if (widget.totalCount > 0 && _progress > 0)
              FractionallySizedBox(
                widthFactor: _progress / widget.totalCount,
                child: Container(
                  height: 32,
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.red.shade800),
                ),
              ),
            Center(
              child: Text(
                  '$_progress / ${widget.totalCount} (${(100 * _progress / widget.totalCount).toInt()}%)  -  ${_foundSets.length} found sets'),
            )
          ],
        ));
  }
}

class ArmorSetList extends StatefulWidget {
  const ArmorSetList({super.key, required this.observable, required this.mobile});

  final Observable observable;
  final bool mobile;

  @override
  State<ArmorSetList> createState() => _ArmorSetListState();
}

class _ArmorSetListState extends State<ArmorSetList> {
  void _listenStream() async {
    widget.observable.observe = () => setState(() {});
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
    _listenStream();
  }

  @override
  void reassemble() {
    super.reassemble();
    //_listenStream(false);
  }

  @override
  void dispose() {
    super.dispose();
    widget.observable.observe = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _foundSets.length,
        prototypeItem: _buildArmorSetTile(context, ArmorSetProperties.dummy, 0),
        itemBuilder: (ctx, index) {
          return _buildArmorSetTile(context, _foundSets[index], index);
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => ArmorSetPage.show(context, widget.mobile, set, true),
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
}
