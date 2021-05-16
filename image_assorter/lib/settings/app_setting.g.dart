// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSetting _$AppSettingFromJson(Map<String, dynamic> json) {
  return AppSetting()
    ..dbPath = json['dbPath'] as String
    ..rootDirectoryPath = json['rootDirectoryPath'] as String
    ..currentDirectoryPath = json['currentDirectoryPath'] as String;
}

Map<String, dynamic> _$AppSettingToJson(AppSetting instance) =>
    <String, dynamic>{
      'dbPath': instance.dbPath,
      'rootDirectoryPath': instance.rootDirectoryPath,
      'currentDirectoryPath': instance.currentDirectoryPath,
    };
