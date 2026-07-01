import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/services/file_download_service.dart';

class StudentPdfView extends StatefulWidget {
  static const routeName = '/student-pdf';
  final String title;
  final String pdfUrl;
  final String fileName;
  const StudentPdfView({
    super.key,
    required this.title,
    required this.pdfUrl,
    required this.fileName,
  });

  @override
  State<StudentPdfView> createState() => _StudentPdfViewState();
}

class _StudentPdfViewState extends State<StudentPdfView> {
  late final PdfViewerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () async {
              try {
                await FileDownloadService.downloadFile(
                  url: widget.pdfUrl,
                  fileName: widget.fileName,
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloaded Successfully')),
                );
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(widget.pdfUrl, controller: _controller),
    );
  }
}
