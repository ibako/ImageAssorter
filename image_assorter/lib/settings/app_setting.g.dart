// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AppSettingToJson(AppSetting instance) =>
    <String, dynamic>{
      'version': instance.version,
      'dbPath': instance.dbPath,
      'rootDirectoryPath': instance.rootDirectoryPath,
      'currentDirectoryPath': instance.currentDirectoryPath,
    };

// **************************************************************************
// PropertyObservableGenerator
// **************************************************************************

mixin _ObservableMembers on PropertyObservable {
  int? __version;
  set version(int? value) {
    if (__version == value) {
      return;
    }
    final oldValue = __version;
    __version = value;
    notifyPropertyChanged(PropertyChangedInfo('version', oldValue, __version));
  }

  String? __dbPath;
  set dbPath(String? value) {
    if (__dbPath == value) {
      return;
    }
    final oldValue = __dbPath;
    __dbPath = value;
    notifyPropertyChanged(PropertyChangedInfo('dbPath', oldValue, __dbPath));
  }

  String? __rootDirectoryPath;
  set rootDirectoryPath(String? value) {
    if (__rootDirectoryPath == value) {
      return;
    }
    final oldValue = __rootDirectoryPath;
    __rootDirectoryPath = value;
    notifyPropertyChanged(PropertyChangedInfo(
        'rootDirectoryPath', oldValue, __rootDirectoryPath));
  }

  String? __currentDirectoryPath;
  set currentDirectoryPath(String? value) {
    if (__currentDirectoryPath == value) {
      return;
    }
    final oldValue = __currentDirectoryPath;
    __currentDirectoryPath = value;
    notifyPropertyChanged(PropertyChangedInfo(
        'currentDirectoryPath', oldValue, __currentDirectoryPath));
  }
}
