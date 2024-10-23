// ignore_for_file: avoid_print
import 'dart:io';
// import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

const localFolderName = 'assets';

class Repository {
  static Repository? _instance;

  Repository._internal() {
    _instance = this;
  }

  factory Repository() => _instance ?? Repository._internal();

  Future<File> _initializeFile(String fileName) async {
    final localDirectory = await getApplicationDocumentsDirectory();
    // var dateFormat = DateFormat('yyyy-MM-dd');
    // var folderName = dateFormat.format(DateTime.now().toLocal());
    await createFolder(localFolderName);
    await createFolder('$localFolderName/$fileName');
    final file = File(
        '${localDirectory.path}/$localFolderName/$fileName/$fileName.json');

    if (!await file.exists()) {
      try {
        await file.create();
        await file.writeAsString("");
      } catch (e) {
        print(e);
      }
    }

    return file;
  }

  Future<String> readFile(String fileName) async {
    final file = await _initializeFile(fileName);
    return await file.readAsString();
  }

  Future<void> writeToFile(String fileName, String data) async {
    final file = await _initializeFile(fileName);
    try {
      var wfile = await file.writeAsString(data);
      print(wfile);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createFolder(String folderName) async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final folder = Directory('${localDirectory.path}/$folderName');

    if (!await folder.exists()) {
      try {
        folder.create();
        print('create');
      } catch (e) {
        print(e);
      }

      return true;
    }

    return false;
  }

  Future<void> deleteFolder(String folderName) async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final folder =
        Directory('${localDirectory.path}/$localFolderName,$folderName');

    if (await folder.exists()) {
      try {
        folder.delete(recursive: true);
      } catch (e) {
        print(e);
      }
    }
  }
}
