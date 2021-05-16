import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:image_assorter/utils/path_util.dart' as pathUtil;

part 'app_setting.g.dart';

/// ローカル保存されるアプリの設定。
@JsonSerializable()
class AppSetting {
  static const _settingFileName = 'setting.json';
  static late AppSetting _instance = AppSetting._internal().._setDefault();

  late String dbPath;
  late String rootDirectoryPath;
  late String currentDirectoryPath;

  // -------------------------------------------------------------------

  AppSetting._internal();
  /// シングルトンにアクセスします。
  factory AppSetting() => _instance;

  // -------------------------------------------------------------------

  /// 設定ファイルを読み込みます。
  Future load() async {
    final file = await _getSettingFile();

    if (!(await file.exists())) {
      await _setDefault();
      return;
    }

    final json = await file.readAsString();
    _$AppSettingFromJson(jsonDecode(json));
  }

  /// 設定ファイルを保存します。
  Future save() async {
    final json = jsonEncode(_$AppSettingToJson(this));
    final file = await _getSettingFile();
    await file.writeAsString(json);
  }

  Future _setDefault() async {
    final directory = pathUtil.cleanPath(
        (await pathProvider.getApplicationSupportDirectory()).path);
    final envVars = Platform.environment;

    dbPath = '$directory/database.sqlite';
    rootDirectoryPath = '${envVars['USERPROFILE']}/Pictures'; // for Test
    currentDirectoryPath = rootDirectoryPath;
  }

  Future<File> _getSettingFile() async {
    final directory = await pathProvider.getApplicationSupportDirectory();
    return File('${directory.path}/$_settingFileName');
  }
}