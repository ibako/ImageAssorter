import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:image_assorter/data/directory_info.dart';
import 'package:image_assorter/models/directory_searcher.dart';

typedef NodeBuilder = Widget Function(DirectoryInfo info);

/// ディレクトリリストの model/view をつなぐ
class DirectoryListController {
  final TreeController treeController = TreeController();
  final DirectorySearcher _directorySearcher = DirectorySearcher();

  /// TreeNode を構築する
  Future<TreeNode> constructNodes(NodeBuilder nodeBuilder) async {
    await _directorySearcher.search();
    return _constructNodesRecursive(
        _directorySearcher.rootDirectoryInfo, nodeBuilder);
  }

  TreeNode _constructNodesRecursive(
      DirectoryInfo directoryInfo, NodeBuilder nodeBuilder) {
    final children = <TreeNode>[];
    for (var child in directoryInfo.children) {
      children.add(_constructNodesRecursive(child, nodeBuilder));
    }
    return _createNode(directoryInfo, children, nodeBuilder);
  }

  TreeNode _createNode(DirectoryInfo directoryInfo, List<TreeNode> children,
          NodeBuilder nodeBuilder) =>
      TreeNode(
        children: children,
        content: nodeBuilder.call(directoryInfo),
      );
}
