import 'package:flutter/material.dart';
import 'package:image_assorter/controllers/file_list_controller.dart';
import 'package:image_assorter/data/file_info.dart';

class FileListWidget extends StatefulWidget {
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileListWidget> {
  final FileListController _controller = FileListController();
  final _listTextStyle = const TextStyle(
      fontSize: 18);

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
        body: StreamBuilder(
          stream: _controller.eventStream.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _buildList();
            }

            final data = snapshot.data;
            if (data is! FileListEvent) {
              throw 'unknown snapshot';
            }
            if (data == FileListEvent.Updating) {
              // くるくる
              return _buildList();
            } else if (data == FileListEvent.Updated) {
              return _buildList();
            } else {
              throw 'unknown snapshot';
            }
          },
        )
      );

  Widget _buildList() {
    final infos = _controller.getFileList();
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: _buildRow(infos[index]),
          ),
      itemCount: infos.length,
    );
  }

  Widget _buildRow(FileInfo info) =>
      ListTile(
        title: Text(
          info.name,
          style: _listTextStyle,
        ),
        trailing: Icon(
          Icons.more_vert,
        ),
        onTap: () {
        },
      );
}