import 'dart:io';
import 'package:image_assorter/data/file_info.dart';

class FileSearcher {
  static const _imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
  final String _directoryPath;

  /// パス -> ファイル情報
  final fileInfoList = <String, FileInfo>{};

  /// コンストラクタ
  FileSearcher(this._directoryPath);

  /// ディレクトリ直下のファイルを検索し、[fileInfoList] に格納する。
  Future search() async {
    final directory = Directory(_directoryPath);

    await for (final file
        in directory.list(followLinks: true, recursive: false)) {
      final lowerPath = file.path.toLowerCase();

      FileType fileType;
      if (await FileSystemEntity.isDirectory(file.path)) {
        fileType = FileType.directory;
      } else if (_imageExtensions.any((x) => lowerPath.endsWith(x))) {
        fileType = FileType.image;
      } else {
        continue;
      }

      fileInfoList[file.path] = FileInfo(file.path, fileType);
    }
  }
}
