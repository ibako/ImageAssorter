import 'dart:async';
import 'package:image_assorter/data/file_info.dart';
import 'package:image_assorter/models/file_searcher.dart';
import 'package:image_assorter/settings/app_setting.dart';

/// view の更新を促すためのイベント
enum FileListEvent {
  /// リスト更新中
  Updating,
  /// リスト更新完了
  Updated,
}

/// ファイルリストの model/view をつなぐ
class FileListController {
  final Map<String, FileSearcher> _fileSearchers = {};
  final StreamController<FileListEvent> eventStream = StreamController<FileListEvent>();

  /// リストを更新します。
  void update() {
    final currentDirectory = AppSetting().currentDirectoryPath;
    final searcher = _fileSearchers.putIfAbsent(currentDirectory, () =>
        FileSearcher(currentDirectory));

    eventStream.add(FileListEvent.Updated);
    searcher.search().then((_) =>
        eventStream.add(FileListEvent.Updated));
  }

  /// リストを取得します。
  List<FileInfo> getFileList() {
    final cache = _fileSearchers[AppSetting().currentDirectoryPath];
    return cache?.fileInfoList.values.toList() ?? [];
  }

  void dispose() {
    eventStream.close();
  }
}
