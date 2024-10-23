import 'package:flutter/material.dart';
import 'package:saleonlinemobile/stateProvider/fileService/file_repo.dart';

class FileRepoController extends ChangeNotifier {
  Future<String> readJsonFile(String fileName) async {
    var fileString = await Repository().readFile(fileName);
    return fileString;
  }

  Future<void> writeJsonFile(String fileName, String data) async {
    await Repository().writeToFile(fileName, data);
  }

  Future<void> createFolder(String folderName) async {
    try {
      var create = Repository().createFolder(folderName);
      // ignore: avoid_print
      print(create);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> deleteFolder(String fileName) async {
    try {
      var create = Repository().deleteFolder(fileName);
      // ignore: avoid_print
      print(create);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
