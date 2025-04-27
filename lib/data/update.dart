
import 'dart:convert';
import 'dart:io';

import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:brachys_armor_set_searcher/data/util.dart';
import 'package:brachys_armor_set_searcher/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'update.freezed.dart';
part 'update.g.dart';

@freezed
abstract class Update with _$Update {

  static final Set<String> _loadedUpdates = {};

  static init() async {
    log.info('Parsing update content');
    var dir = await getApplicationCacheDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    dir = Directory('${dir.path}/updates');
    log.info(dir.path);
    if (await dir.exists()) {
      await for (var fileEntity in dir.list(recursive: false, followLinks: false)) {
        var file = File(fileEntity.path);
        var id = file.path.substring(file.path.lastIndexOf('/'), file.path.lastIndexOf('.'));
        log.info(' - update:$id');
        Json json = jsonDecode(await file.readAsString());
        All.parseFromUpdateJson(json);
        _loadedUpdates.add(id);
      }
    } else {
      await dir.create(recursive: true);
    }
    _download();
  }

  static _download() async {
    log.info('Checking update data');
    final response = await http.Client().get(Uri.parse('https://raw.githubusercontent.com/brachy84/Brachydium-MHW/refs/heads/wilds/assets/data/wilds/updates/index.json'));
    if (response.statusCode == 200) {
      var dir = await getApplicationCacheDirectory();
      var j = jsonDecode(response.body);
      for (Json json in j['updates']) {
        Update update = Update.fromJson(json);
        if (_loadedUpdates.contains(update.id)) continue;
        if (getVersionNumber(packageInfo.version) < getVersionNumber(update.minVersion)) {
          log.info('Min version for update ${update.id} is ${update.minVersion}, but version is ${packageInfo.version}');
          continue;
        }
        if (DateTime.now().isBefore(update.availableSince)) {
          log.info('Update ${update.id} is available at ${update.availableSince}');
          continue;
        }
        final response1 = await http.Client().get(Uri.parse('https://raw.githubusercontent.com/brachy84/Brachydium-MHW/refs/heads/wilds/assets/data/wilds/updates/${update.id}.json'));
        if (response1.statusCode == 200) {
          Json json = jsonDecode(response1.body);
          All.parseFromUpdateJson(json);
          _loadedUpdates.add(update.id);
          var file = File('${dir.path}/updates/${update.id}.json');
          if (await file.exists()) {
            file.delete();
          }
          await file.create();
          await file.writeAsString(response1.body);
        } else {
          log.error('Failed to download update ${update.id}');
        }
      }
    }
  }


  const factory Update({
    required String id,
    required String minVersion,
    required DateTime availableSince,
    @Default(0) int updateVersion,
  }) = _Update;

  factory Update.fromJson(Map<String , dynamic> json) => _$UpdateFromJson(json);
}
