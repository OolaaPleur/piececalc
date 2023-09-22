import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/database/database_operations.dart';

/// A service class responsible for backup-related operations.
///
/// It provides methods to convert data to CSV format and to create
/// and share backup files.
class BackupService {
  /// Converts a given list of maps [dataList] into CSV format.
  ///
  /// The returned string contains headers from the map's keys and
  /// values separated by commas. If [dataList] is empty, an empty
  /// string is returned.
  String convertToCSV(List<Map<String, dynamic>> dataList) {
    if (dataList.isEmpty) return '';
    // Rows
    final buffer = StringBuffer()
      // Headers
      ..write('${dataList[0].keys.join(',')}\n');
    for (final data in dataList) {
      buffer.write('${data.values.join(',')}\n');
    }

    return buffer.toString();
  }

  /// Creates a backup file in CSV format containing data from the database.
  ///
  /// This method fetches data from the 'works' and 'done_works' tables,
  /// converts them to CSV format, writes them to a file, and initiates
  /// a sharing intent for the user to share the backup file.
  Future<void> createBackupAndShare({required String subject, required String text}) async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    final worksList = await db.query('works');
    final doneWorksList = await db.query('done_works');

    final worksCSV = convertToCSV(worksList);
    final doneWorksCSV = convertToCSV(doneWorksList);
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/piececalc.csv';
      final file = File(filePath);
      await file.writeAsString('$worksCSV\n\n$doneWorksCSV');
      await Share.shareXFiles([XFile(filePath)], subject: subject, text: text);
    }
    if (kIsWeb) {
      final String csvContent = '$worksCSV\n\n$doneWorksCSV';
      final blob = html.Blob([Uint8List.fromList(utf8.encode(csvContent))], 'text/csv');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "piececalc.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }
}
