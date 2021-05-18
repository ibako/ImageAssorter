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
            stream: _controller.eventStream.stream,
            noDataWidget: _buildList,
            updatingWidget: _buildList,
            updatedWidget: _buildList),
        );

  Widget _buildList() {
    final fileList = _controller.getFileList();
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
  final FileInfo _fileInfo;
  late FileRowController _controller = FileRowController(_fileInfo);
  final _listTextStyle = const TextStyle(
      fontSize: 18);

  _FileRowState(this._fileInfo);

  @override
  Widget build(BuildContext context) =>
      ListTile(
        leading: createFutureBuilder(
            heavyWidgetGenerator: _createThumbnail(_fileInfo),
            updatingWidget: () => Icon(Icons.image),
        ),
        title: Text(
          _fileInfo.name,
          style: _listTextStyle,
        ),
        trailing: Icon(
          Icons.more_vert,
        ),
        onTap: () {
        },
      );

  Future<Widget> _createThumbnail(FileInfo info) {
    return Future(() =>
        Image.file(
          File(_fileInfo.path),
          cacheWidth: 32,
          cacheHeight: 32,
      ),
    );
  }
}