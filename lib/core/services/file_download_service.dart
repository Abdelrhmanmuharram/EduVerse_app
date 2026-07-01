import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadService {
  static final Dio _dio = Dio();

  static Future<void> downloadFile({
    required String url,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    await _dio.download(url, filePath);
    await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        sourceFilePath: filePath,
        fileName: fileName,
      ),
    );
  }
}
