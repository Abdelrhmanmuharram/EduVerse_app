import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/widgets/back_item.dart';

class PdfView extends StatelessWidget {
  static const routeName = "/pdf-view";

  final String url;
  final String title;

  const PdfView({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}
