import 'dart:io';
import 'package:image_assorter/data/file_info.dart';

class FileSearcher {
  final String _directoryPath;

  /// パス -> ファイル情報
  final Map<String, FileInfo> fileInfoList = {};

  /// コンストラクタ
  FileSearcher(this._directoryPath);

  /// ディレクトリ直下のファイルを検索し、fileInfoList に格納する。
  Future search() async {
    final directory = Directory(_directoryPath);

    await for (final file in directory.list(followLinks: true, recursive: false)) {
      fileInfoList[file.path] = FileInfo(file.path);
    }
  }
}
