import 'package:flutter/material.dart';
import 'package:image_assorter/views/directory_list_widget.dart';
import 'package:image_assorter/views/file_list_widget.dart';
import 'package:resizable_widget/resizable_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [Icon(Icons.settings), Container(width: 16)],
      ),
      body: Center(
          child: Card(
              margin: EdgeInsets.all(16),
              child: ResizableWidget(
                children: [
                  DirectoryListWidget(),
                  FileListWidget(),
                  Container(),
                ],
                percentages: [
                  0.2,
                  0.6,
                  0.2,
                ],
              ))),
    );
  }
}
