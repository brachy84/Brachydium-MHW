import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/util.dart';
import 'package:path_provider/path_provider.dart';

import 'equipment.dart';

var currentProfile = Profile('main');

class Profile {

  static Timer? _timer;

  final String name;
  int version = 0;
  SearcherArgsState? _args;
  final Map<String, ArmorSet> armorSets = {};

  Profile(this.name);

  SearcherArgsState get args {
    _args ??= SearcherArgsState.initial();
    return _args!;
  }

  set args(SearcherArgsState args) {
    _args = args;
    // save after 5 seconds and cancel current scheduled save
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 5), () {
      save();
      _timer = null;
    });
  }

  void readFromJson(Json json) {
    version = json['v'];
    _args = SearcherArgsState.fromJson(json['args']);
    for (var j in (json['armorSets'] as List<dynamic>)) {
      armorSets[j['name']] = ArmorSet.fromJson(json);
    }
  }

  void initDefault() {
    armorSets.clear();
    _args = SearcherArgsState.initial();
  }

  Json saveToJson() {
    Json json = {};
    json['v'] = version;
    json['args'] = _args?.toJson();
    json['armorSets'] = armorSets.entries.map((e) {
      var j = e.value.toJson();
      j['name'] = e.key;
      return j;
    }).toList();
    return json;
  }

  static save() async {
    var file = await _getFile();
    if (!await file.exists()) {
      await file.create(recursive: false);
    }
    file.writeAsString(jsonEncoder.convert(currentProfile.saveToJson()));
  }

  static init() async {
    log.info('Init profiles');
    var file = await _getFile();
    if (!await file.exists()) {
      currentProfile.initDefault();
      save();
      return;
    }
    currentProfile.readFromJson(jsonDecode(await file.readAsString()));
  }

  static Future<File> _getFile() async {
    var dir = await getApplicationCacheDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return File('${dir.path}/profiles.json');
  }
}
