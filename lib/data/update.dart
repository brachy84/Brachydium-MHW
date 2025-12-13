import 'dart:convert';
import 'dart:io';

import 'package:brachydium_searcher/data/equipment.dart';
import 'package:brachydium_searcher/data/util.dart';
import 'package:brachydium_searcher/main.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'update.freezed.dart';

part 'update.g.dart';

@freezed
abstract class Update with _$Update {
  static final Map<String, int> _loadedUpdates = {};

  static init() async {
    log.info('Parsing update content');
    var dir = await getApplicationCacheDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    dir = Directory('${dir.path}/updates');
    log.info(dir.path);
    await _loadUpdateFromAssets(dir);
    if (await dir.exists()) {
      await for (var fileEntity in dir.list(recursive: false, followLinks: false)) {
        var file = File(fileEntity.path);
        var id = file.path.substring(file.path.lastIndexOf('/'), file.path.lastIndexOf('.'));
        if (_loadedUpdates.containsKey(id)) {
          // shouldn't happen
          if (await file.exists()) {
            file.delete(); // delete cached local update
          }
          continue;
        }
        log.info(' - loading locally cached update $id');
        Json json = jsonDecode(await file.readAsString());
        All.parseFromUpdateJson(json);
        _loadedUpdates[id] = json['v'];
      }
    } else {
      await dir.create(recursive: true);
    }
    _download();
  }

  static _loadUpdateFromAssets(Directory updateDir) async {
    var index = await rootBundle.loadString('assets/data/wilds/updates/index.json');
    var j = jsonDecode(index);
    for (Json json in j['updates']) {
      Update update = Update.fromJson(json);
      if (update.ignore) continue;
      log.info(' - loading update ${update.id} from shipped assets');
      var content = jsonDecode(await rootBundle.loadString('assets/data/wilds/updates/${update.id}.json'));
      All.parseFromUpdateJson(content);
      _loadedUpdates[update.id] = update.updateVersion;
      // remove locally stored update if it was downloaded with an older app version
      // since the update is now shipped
      var file = File('${updateDir.path}/${update.id}.json');
      if (await file.exists()) {
        log.info('   - deleting old local update files');
        file.delete(); // delete cached local update
      }
    }
  }

  static _download() async {
    log.info('Checking update data');
    final response = await http.Client().get(Uri.parse(
        'https://raw.githubusercontent.com/brachy84/Brachydium-MHW/refs/heads/wilds/assets/data/wilds/updates/index.json'));
    var status = (response.statusCode / 100).floor();
    if (status == 5) {
      log.error('No internet connection');
      return;
    }
    if (status == 4) {
      log.error('Internal http error');
      return;
    }
    if (status == 2) {
      var dir = await getApplicationCacheDirectory();
      var j = jsonDecode(response.body);
      for (Json json in j['updates']) {
        Update update = Update.fromJson(json);
        if (update.ignore) continue;
        var current = _loadedUpdates[update.id] ?? -1;
        if (update.updateVersion <= current) continue; // we already have this update locally
        if (getVersionNumber(packageInfo.version) < getVersionNumber(update.minVersion)) {
          log.info(
              ' - min version for update ${update.id} is ${update.minVersion}, but version is ${packageInfo.version}');
          continue;
        }
        if (DateTime.now().isBefore(update.availableSince)) {
          log.info('Update ${update.id} is available at ${update.availableSince}');
          continue;
        }
        log.info(' - loading downloaded update ${update.id}');
        final response1 = await http.Client().get(Uri.parse(
            'https://raw.githubusercontent.com/brachy84/Brachydium-MHW/refs/heads/wilds/assets/data/wilds/updates/${update.id}.json'));
        if (response1.statusCode == 200) {
          Json json = jsonDecode(response1.body);
          All.parseFromUpdateJson(json); // load update
          json['v'] = update.updateVersion; // save version of update in case the update needs to be updated
          _loadedUpdates[update.id] = update.updateVersion;
          var file = File('${dir.path}/updates/${update.id}.json');
          if (await file.exists()) {
            file.delete(); // delete cached local update
          }
          await file.create();
          await file.writeAsString(jsonEncoder.convert(json)); // save update locally
        } else {
          log.error('   - failed to download update ${update.id} with code ${response1.statusCode}');
        }
      }
    }
  }

  const factory Update(
      {required String id,
      required String minVersion,
      required DateTime availableSince,
      @Default(0) int updateVersion,
      @Default(false) bool ignore}) = _Update;

  factory Update.fromJson(Map<String, dynamic> json) => _$UpdateFromJson(json);
}
