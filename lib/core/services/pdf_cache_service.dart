import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';

class PdfCacheService {
  static Future<File> getPdf(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    if (await file.exists()) {
      return file;
    }
    await Dio().download(url, filePath);
    return file;
  }

  static Future<bool> downloadPdf(String url, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$fileName.pdf');
    await Dio().download(url, tempFile.path);
    final result = await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        sourceFilePath: tempFile.path,
        fileName: '$fileName.pdf',
      ),
    );
    return result != null;
  }
}
