
import 'package:Easy_shopping_admin/api/api.dart';
import 'package:Easy_shopping_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PdfViewScreen extends StatefulWidget {
  final pdfstate;
  PdfViewScreen(this.pdfstate);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
     //getPermission();
    loadDocument();
  }

  loadDocument() async {
    setState(() => _isLoading = true);
print(CallApi().getUrl() + widget.pdfstate['pdfImage']);
    document = await PDFDocument.fromURL(CallApi().getUrl() + widget.pdfstate['pdfImage']);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfstate['pdfName']),
        automaticallyImplyLeading: true,
        backgroundColor: appColor,
        // actions: [IconButton(icon: Icon(Icons.file_download), onPressed: () async{
        // })
        // ],

      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      ),
    );
  }

}
