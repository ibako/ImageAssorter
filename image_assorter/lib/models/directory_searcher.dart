import 'dart:io';
import 'package:image_assorter/data/directory_info.dart';
import 'package:image_assorter/settings/app_setting.dart';

class DirectorySearcher {
  /// ルートディレクトリの情報
  late DirectoryInfo rootDirectoryInfo;

  /// ルートディレクトリ以下のディレクトリを検索し、[rootDirectoryInfo] に格納する。
  Future search() async {
    final root = AppSetting().rootDirectoryPath;
    await _createRecursive(root);
  }

  Future<DirectoryInfo> _createRecursive(String path) async {
    final lowerPath = path.toLowerCase();
    final directory = Directory(lowerPath);

    final subDirectoryList = <DirectoryInfo>[];
    await for (final file in directory.list()) {
      final childLowerPath = file.path.toLowerCase();
      if (await FileSystemEntity.isDirectory(childLowerPath)) {
        subDirectoryList.add(await _createRecursive(childLowerPath));
      }
    }

    return DirectoryInfo(lowerPath, subDirectoryList);
  }
}
