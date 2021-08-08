import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl(
      {Key key, @required this.url, @required this.name})
      : super(key: key);

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Get.theme.primaryColor,
        centerTitle: true,
        title: Text(name),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
