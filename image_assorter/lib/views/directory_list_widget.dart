import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:image_assorter/controllers/directory_list_controller.dart';
import 'package:image_assorter/data/directory_info.dart';
import 'package:image_assorter/helpers/async_widget_helper.dart';

class DirectoryListWidget extends StatefulWidget {
  @override
  _DirectoryListState createState() => _DirectoryListState();
}

class _DirectoryListState extends State<DirectoryListWidget> {
  static const double _imageHeight = 30;
  final _controller = DirectoryListController();

  @override
  Widget build(BuildContext context) => createFutureBuilder(
      heavyWidgetGenerator: _buildTreeView(context),
      updatingWidget: _buildUpdatingView);

  Future<Widget> _buildTreeView(BuildContext context) async {
    final rootNode = await _controller.constructNodes(_nodeBuilder);
    return TreeView(
      nodes: [rootNode],
      treeController: _controller.treeController,
    );
  }

  Widget _nodeBuilder(DirectoryInfo info) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black38),
        ),
      ),
      child: ListTile(
        leading: Container(
          child: Icon(
            Icons.folder,
            size: _imageHeight,
            color: Colors.blue,
          ),
        ),
        title: Text(
          info.name,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => {},
      ),
    ));
  }

  Widget _buildUpdatingView() {
    return Container();
  }
}
