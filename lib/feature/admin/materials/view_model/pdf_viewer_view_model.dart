import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/pdf_cache_service.dart';

class PdfViewerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  File? _pdfFile;
  File? get pdfFile => _pdfFile;

  Future<void> loadPdf(String url, String fileName) async {
    try {
      _isLoading = true;
      notifyListeners();

      _pdfFile = await PdfCacheService.getPdf(url, fileName);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
