import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CreateFileDebug {
  final String message;

  CreateFileDebug({this.message});

  generateFile() {
    //_writeFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> _writeFile() async {
    String value = await _readFile();
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(message + "\n\n" + value);
  }

  Future<String> _readFile() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents ?? "";
    } catch (e) {
      return "";
    }
  }
}
