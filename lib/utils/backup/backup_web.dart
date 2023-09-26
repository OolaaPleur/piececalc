import 'dart:convert';
import 'dart:typed_data';

import 'package:universal_html/html.dart' as html;

Future<void> createAndShareBackupWeb(
    {required String worksCSV, required String doneWorksCSV, required String subject, required String text, required String fileName,}) async {
  final csvContent = '$worksCSV\n\n$doneWorksCSV';
  final blob = html.Blob([Uint8List.fromList(utf8.encode(csvContent))], 'text/csv');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', '$fileName.csv')
    ..click();
  html.Url.revokeObjectUrl(url);
}
