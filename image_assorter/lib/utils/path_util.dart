/// ファイルパスからディレクトリ情報を取り除いたものを返します。
String getFileName(String filePath) {
  return cleanPath(filePath)
      .split('/')
      .last;
}

/// ファイルパスの表記揺れを是正します。
String cleanPath(String path) {
  return path
      .replaceAll('\\', '/')
      .toLowerCase();
}