import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:image_assorter/data/directory_info.dart';
import 'package:image_assorter/models/directory_searcher.dart';

/// ディレクトリリストの model/view をつなぐ
class DirectoryListController {
  final DirectorySearcher _directorySearcher = DirectorySearcher();
  late TreeViewController treeViewController;

  /// TreeNodeを構築する
  Future constructNodes() async {
    await _directorySearcher.search();
    final rootNode =
        _constructNodesRecursive(_directorySearcher.rootDirectoryInfo);
    treeViewController = TreeViewController(
      //selectedKey:
      children: [rootNode],
    );
  }

  Node _constructNodesRecursive(DirectoryInfo directoryInfo) {
    final children = <Node>[];
    for (var child in directoryInfo.children) {
      children.add(_constructNodesRecursive(child));
    }
    return _createNode(directoryInfo, children);
  }

  Node _createNode(DirectoryInfo directoryInfo, List<Node> children) => Node(
        children: children,
        key: directoryInfo.path,
        label: directoryInfo.name,
        icon: Icons.folder,
        expanded: true,
      );
}
