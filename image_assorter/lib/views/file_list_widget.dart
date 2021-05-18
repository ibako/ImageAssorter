import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_assorter/controllers/file_list_controller.dart';
import 'package:image_assorter/data/file_info.dart';
import 'package:image_assorter/helpers/async_widget_helper.dart';

class FileListWidget extends StatefulWidget {
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileListWidget> {
  final FileListController _controller = FileListController();

  @override
  void initState() {
    super.initState();
    _controller.update();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: createStreamBuilder(
            _controller.eventStream.stream,
            defaultWidget: _buildList
        ),
      );

  Widget _buildList() {
    final fileList = _controller.getFileList()
        ..sort((x, y) => x.fileType.index.compareTo(y.fileType.index));
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: _FileRowWidget(fileList[index]),
          ),
      itemCount: fileList.length,
    );
  }

}

// ------------------------------------------------------------------

class _FileRowWidget extends StatefulWidget {
  final FileInfo _fileInfo;

  _FileRowWidget(this._fileInfo);

  @override
  _FileRowState createState() => _FileRowState(_fileInfo);
}

class _FileRowState extends State<_FileRowWidget> {
  static const double _imageHeight = 42;

  final FileInfo _fileInfo;
  late FileRowController _controller = FileRowController(_fileInfo);
  final _listTextStyleNormal = const TextStyle(fontSize: 18);
  final _listTextStyleError = const TextStyle(fontSize: 18, color: Colors.red);

  _FileRowState(this._fileInfo);

  @override
  Widget build(BuildContext context) =>
      ListTile(
        leading: Container(
          width: 64,
          margin: EdgeInsets.all(2),
          child: Center(
            child: createFutureBuilder(
              heavyWidgetGenerator: _createThumbnail(_fileInfo),
              updatingWidget: () => Icon(Icons.image),
            ),
          ),
        ),
        title: createStreamBuilder(
          _controller.eventStream.stream,
          defaultWidget: _createTitle,
        ),
        trailing: Icon(
          Icons.more_vert,
        ),
        onTap: () {
        },
      );

  Future<Widget> _createThumbnail(FileInfo info) {
    return Future(() {
      if (info.fileType == FileType.directory) {
        return Icon(Icons.folder, size: _imageHeight, color: Colors.blue,);
      }

      try {
        return Image.file(
          File(_fileInfo.path),
          height: _imageHeight,
          isAntiAlias: true,
          errorBuilder: (context, error, stackTrace) => _createErrorThumbnail(),
        );
      } catch (e) {
        return _createErrorThumbnail();
      }
    });
  }

  Widget _createErrorThumbnail() {
    _controller.setAsError();
    return Icon(Icons.error, size:_imageHeight, color: Colors.red);
  }

  Widget _createTitle() =>
      Text(
        _fileInfo.name,
        style: _controller.isError ? _listTextStyleError : _listTextStyleNormal,
      );
}