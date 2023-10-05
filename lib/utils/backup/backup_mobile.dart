import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Create and share backup, mobile version.
Future<void> createAndShareBackupMobile({
  required String worksCSV,
  required String doneWorksCSV,
  required String subject,
  required String text,
  required String fileName,
}) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName.csv';
  final file = File(filePath);
  await file.writeAsString('$worksCSV\n\n$doneWorksCSV');
  await Share.shareXFiles([XFile(filePath)], subject: subject, text: text);
}
