import 'package:image_assorter/utils/path_util.dart' as pathUtil;

/// ファイルの種類
enum FileType {
  directory,
  image,
}

/// ファイル情報
class FileInfo {
  /// ファイルパス
  final String path;
  /// ファイルの種類
  final FileType fileType;
  /// ファイルパスからディレクトリ情報を取り除いたもの
  String get name => pathUtil.getFileName(path);

  /// const コンストラクタ
  const FileInfo(this.path, this.fileType);
}