import 'dart:async';
import 'package:image_assorter/controllers/file_list_controller.dart';
import 'package:image_assorter/data/file_info.dart';
import 'package:image_assorter/data/update_notification_event.dart';
import 'package:image_assorter/settings/app_setting.dart';

/// ファイルリストの1行の model/view をつなぐ
class FileRowController {
  final FileInfo fileInfo;
  final FileListController _parentController;
  final eventStream = StreamController<UpdateNotificationEvent>();

  bool get isError => _isError;
  bool _isError = false;

  FileRowController(this.fileInfo, this._parentController);

  void setAsError() {
    _isError = true;
    eventStream.add(UpdateNotificationEvent.updated);
  }

  void onTap() {
    if (fileInfo.fileType == FileType.directory) {
      AppSetting().currentDirectoryPath = fileInfo.path;

      _parentController.eventStream.add(UpdateNotificationEvent.updating);
      _parentController.update();
      _parentController.eventStream.add(UpdateNotificationEvent.updated);
    }
  }

  void dispose() {
    eventStream.close();
  }
}
