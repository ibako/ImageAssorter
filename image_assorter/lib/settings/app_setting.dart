import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:image_assorter/utils/path_util.dart' as pathUtil;
import 'package:simple_property_observer/simple_property_observer.dart';

part 'app_setting.g.dart';

/// ローカル保存されるアプリの設定。
@JsonSerializable(createFactory: false)
@propertyObservable
class AppSetting with PropertyObservable, _ObservableMembers {
  static const _settingFileName = 'setting.json';
  static late AppSetting _instance = AppSetting._internal().._setDefault();

  @JsonKey(name: 'version')
  @observable
  int? get version => __version;

  @JsonKey(name: 'dbPath')
  @observable
  String? get dbPath => __dbPath;

  @JsonKey(name: 'rootDirectoryPath')
  @observable
  String? get rootDirectoryPath => __rootDirectoryPath;

  @JsonKey(name: 'currentDirectoryPath')
  @observable
  String? get currentDirectoryPath => __currentDirectoryPath;

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
    //TODO 保存ファイルのバージョン違い時の吸収処理
    try {
      _appSettingFromJson(jsonDecode(json));
    } catch (exception) {
      _setDefault();
    }
  }

  /// 設定ファイルを保存します。
  Future save() async {
    final json = jsonEncode(_$AppSettingToJson(this));
    final file = await _getSettingFile();
    await file.writeAsString(json);
  }

  Future _setDefault() async {
    final directory = pathUtil
        .cleanPath((await pathProvider.getApplicationSupportDirectory()).path);
    final envVars = Platform.environment;

    version = 1;
    dbPath = '$directory/database.sqlite';
    rootDirectoryPath = '${envVars['USERPROFILE']}/Pictures'; // for Test
    currentDirectoryPath = rootDirectoryPath;
  }

  Future<File> _getSettingFile() async {
    final directory = await pathProvider.getApplicationSupportDirectory();
    return File('${directory.path}/$_settingFileName');
  }

  AppSetting _appSettingFromJson(Map<String, dynamic> json) {
    return AppSetting()
      ..version = json['dbPath'] as int
      ..dbPath = json['dbPath'] as String
      ..rootDirectoryPath = json['rootDirectoryPath'] as String
      ..currentDirectoryPath = json['currentDirectoryPath'] as String;
  }
}
