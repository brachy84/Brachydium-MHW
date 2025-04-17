
import 'dart:isolate';

import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart';

typedef DataHandler = void Function(dynamic);

const String _START_PROCESS = 'start_prc';
const String _END_PROCESS = 'end_prc';
const String _CANCEL_PROCESS = 'cancel_prc';

Isolate? _isolate;
final ReceivePort _receivePort = ReceivePort();
SendPort? _sendPort;

ReceivePort? _receivePortIsolate;

Map<String, DataHandler> _dataHandlersMain = {};
Map<String, DataHandler> _dataHandlersIsolate = {};

String? _activeProcess;
DataHandler? _activeDataHandler;

List<String> _processQueue = [];
List<Object?> _msgQueue = [];

bool get hasActiveIsolateProcess => _activeProcess != null;

void startIsolate() async {
  _receivePort.listen((d) {
    if (d is SendPort) {
      _sendPort = d;
    } else if (_activeDataHandler != null) {
      _activeDataHandler!(d);
    }
  });

  _isolate = await Isolate.spawn((SendPort port) async {
    ReceivePort controlReceivePort = ReceivePort('Control port isolate side');
    port.send(controlReceivePort.sendPort);
    _receivePortIsolate = controlReceivePort;
    _receivePortIsolate!.listen((d) {
      if (_activeDataHandler != null) {
        _activeDataHandler!(d);
      }
    });
    await All.init();
  }, _receivePort.sendPort);
}

void registerDataHandler(DataHandler dh) {
  _dataHandlersMain.add(dh);
}

void sendToIsolate(Object? msg) {
  _sendPort!.send(msg);
}

void isolateOperation(String id, Object? msg) {
  if (_sendPort == null || hasActiveIsolateProcess) {
    _processQueue.add(id);
    _msgQueue.add(msg);
    return;
  }
  _activeProcess = id;
  _activeDataHandler = _dataHandlersMain[id];
  _sendPort!.send({_START_PROCESS: id, 'msg': msg});
}

Future<SearchResult> searchAllArmorCombinations(SearchArguments arguments) async {
  SearchResult result = SearchResult();
  DataHandler dh = (d) {
    return true;
  };
  sendToIsolate({'StartSearch' : arguments.toJson()});
  return result;
}

