import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

/// ユーザーにディレクトリを選択してもらい、選択されたディレクトリを返します。
Future<String?> getDirectoryPath() async {
  return await FileSelectorPlatform.instance
      .getDirectoryPath();
}

Future<XFile?> getImageFile() async {
  return await FileSelectorPlatform.instance
      .openFile(
    acceptedTypeGroups: [_imageXTypeGroup],
  );
}

Future<List<XFile>> getImageFiles() async {
  return await FileSelectorPlatform.instance
      .openFiles(
    acceptedTypeGroups: [_imageXTypeGroup],
  );
}

// ----------------------------------------------------------------

final XTypeGroup _imageXTypeGroup = XTypeGroup(
  label: 'images',
  extensions: ['jpg', 'jpeg', 'png', 'bmp', 'gif'],
);
