import 'package:image_assorter/utils/path_util.dart' as pathUtil;

/// ディレクトリの情報
class DirectoryInfo {
  /// ディレクトリパス
  final String path;

  /// 子ディレクトリのリスト
  final List<DirectoryInfo> children;

  /// パスから親ディレクトリ情報を取り除いたもの
  String get name => pathUtil.getFileName(path);

  const DirectoryInfo(this.path, this.children);
}
