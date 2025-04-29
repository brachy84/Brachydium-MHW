import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/util.dart';
import 'package:path_provider/path_provider.dart';

import 'equipment.dart';

var currentProfile = _getOrCreateProfile('main');

Map<String, Profile> _allProfiles = {};

void _registerProfile(Profile profile) {
  _allProfiles[profile.name] = profile;
}

Profile _createProfile(String name) {
  Profile p = Profile(name);
  _registerProfile(p);
  return p;
}

Profile _getOrCreateProfile(String name) {
  return _allProfiles[name] ?? _createProfile(name);
}

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
    _scheduleUpdate();
  }

  set armorSets(Map<String, ArmorSet> sets) {
    armorSets.clear();
    armorSets.addAll(sets);
    _scheduleUpdate();
  }

  _scheduleUpdate() {
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
      armorSets[j['name']] = ArmorSet.fromJson(j);
    }
  }

  void initDefault() {
    armorSets.clear();
    _args = SearcherArgsState.initial();
  }

  Json toJson() {
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
    Json json = {};
    for (var e in _allProfiles.entries) {
      json[e.key] = e.value.toJson();
    }
    file.writeAsString(jsonEncoder.convert(json));
  }

  static init() async {
    log.info('Init profiles');
    var file = await _getFile();
    if (!await file.exists()) {
      currentProfile.initDefault();
      save();
      return;
    }
    Json json = jsonDecode(await file.readAsString());
    for (var e in json.entries) {
      var p = _getOrCreateProfile(e.key);
      p.readFromJson(e.value);
    }
  }

  static Future<File> _getFile() async {
    var dir = await getApplicationCacheDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return File('${dir.path}/profiles.json');
  }
}
