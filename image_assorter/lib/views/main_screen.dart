import 'package:flutter/material.dart';
import 'package:image_assorter/views/file_list_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
            margin: EdgeInsets.all(16),
            child: FileListWidget(),
          )
      ),
    );
  }
}
