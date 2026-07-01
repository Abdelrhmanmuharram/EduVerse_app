import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> openPdf(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Couldn't open pdf");
    }
  }
}
