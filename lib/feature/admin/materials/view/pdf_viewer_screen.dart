import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../view_model/pdf_viewer_view_model.dart';

class PdfViewerScreen extends StatefulWidget {
  static const String routeName = '/pdf-viewer';

  final String pdfUrl;
  final String title;
  final String fileName;
  const PdfViewerScreen({
    super.key,
    required this.pdfUrl,
    required this.title,
    required this.fileName,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PdfViewerViewModel>().loadPdf(
        widget.pdfUrl,
        widget.fileName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<PdfViewerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: textTheme.headlineSmall),
        centerTitle: true,
        leading: const BackItem(),
      ),
      body: viewModel.isLoading || viewModel.pdfFile == null
          ? const Center(
        child: LoadingWidget(),
      )
          : SfPdfViewer.file(
        viewModel.pdfFile!,
        canShowScrollHead: false,
        canShowPaginationDialog: false,
      ),
    );
  }
}
