import 'dart:async';
import 'package:image_assorter/data/file_info.dart';
import 'package:image_assorter/data/update_notification_event.dart';
import 'package:image_assorter/models/file_searcher.dart';
import 'package:image_assorter/settings/app_setting.dart';

/// ファイルリストの model/view をつなぐ
class FileListController {
  final _fileSearchers = <String, FileSearcher>{};
  final eventStream = StreamController<UpdateNotificationEvent>();

  /// リストを更新します。
  void update() {
    final currentDirectory = AppSetting().currentDirectoryPath!;
    final searcher = _fileSearchers.putIfAbsent(
        currentDirectory, () => FileSearcher(currentDirectory));

    eventStream.add(UpdateNotificationEvent.updating);
    searcher
        .search()
        .then((_) => eventStream.add(UpdateNotificationEvent.updated));
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
