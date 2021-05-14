import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_assorter/utils/file_dialog_util.dart' as fileDialogUtil;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Assorter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (context) => FilePickScreen(),
      },
    );
  }
}

class FilePickScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: FilePickForm(),
        )
      ),
    );
  }
}

class FilePickForm extends StatefulWidget {
  @override
  _FilePickState createState() => _FilePickState();
}

class _FilePickState extends State<FilePickForm> {
  final _rootPathTextController = TextEditingController();
  final _selectedFileTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: _rootPathTextController,
                readOnly: true,
                decoration: InputDecoration(hintText: 'Selected directory'),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                  child: Text('Select...'),
                  onPressed: _selectDirectory
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: _selectedFileTextController,
                readOnly: true,
                decoration: InputDecoration(hintText: 'Selected image file'),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                child: Text('Select...'),
                onPressed: _selectImage)
            ),
          ],
        ),
      ],
    );
  }

  void _selectDirectory() async {
    final selectedDirectory = await fileDialogUtil.getDirectoryPath() ?? '';
    setState(() {
      _rootPathTextController.text = selectedDirectory;
    });
  }

  void _selectImage() async {
    final selectedImage = await fileDialogUtil.getImageFile();
    final selectedPath = selectedImage?.path ?? '';
    setState(() {
      _selectedFileTextController.text = selectedPath;
    });
  }
}