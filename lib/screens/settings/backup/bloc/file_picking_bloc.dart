import 'dart:convert';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../../utils/backup/backup_mobile.dart';
import '../../../../utils/backup/backup_web.dart';
import '../../../../utils/database/database_operations.dart';

/// Enum representing the various statuses that can occur during file picking and processing.
enum FilePickingStatus {
  /// Initial status before any operation has occurred.
  /// Typically the default state.
  initial,

  /// Indicates that a CSV file has been successfully picked.
  pickedCSV,

  /// Indicates that a file other than a CSV has been picked.
  pickedOther,

  /// Indicates that no file was picked when the file picker dialog was presented.
  noFilePicked,

  /// Indicates that the picked file is not a valid backup file.
  /// This could occur if the file's content doesn't match expected format.
  fileIsNotBackup,

  /// Indicates that data has been successfully uploaded from the picked file.
  dataUploaded,
}

/// State class for [FilePickingBloc].
class FilePickingState extends Equatable {
  /// Constructor for [FilePickingState].
  const FilePickingState({required this.status});

  /// Current status of state of [FilePickingBloc].
  final FilePickingStatus status;

  @override
  List<Object> get props => [status];

  /// Copywith function for [FilePickingState].
  FilePickingState copyWith({
    FilePickingStatus? status,
  }) {
    return FilePickingState(
      status: status ?? this.status,
    );
  }
}

/// A service class responsible for backup-related operations.
///
/// It provides methods to convert data to CSV format and to create
/// and share backup files.
class FilePickingBloc extends Cubit<FilePickingState> {
  /// Constructor for [FilePickingBloc].
  FilePickingBloc() : super(const FilePickingState(status: FilePickingStatus.initial));

  /// First line, must be in backup.
  static const firstLine =
      'PieceCa(lc) backup. DO NOT CHANGE ITS CONTENT, IT COULD LEAD TO ERASING AND UNEXPECTED ERRORS';

  /// Converts a given list of maps [dataList] into CSV format.
  ///
  /// The returned string contains headers from the map's keys and
  /// values separated by commas. If [dataList] is empty, an empty
  /// string is returned.
  String convertToCSV(List<Map<String, dynamic>> dataList) {
    if (dataList.isEmpty) return '';
    // Rows
    final buffer = StringBuffer()
      ..write('$firstLine\n')
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
      await createAndShareBackupMobile(
        worksCSV: worksCSV,
        doneWorksCSV: doneWorksCSV,
        subject: subject,
        text: text,
        fileName: 'piececalc',
      );
    }
    if (kIsWeb) {
      await createAndShareBackupWeb(
        worksCSV: worksCSV,
        doneWorksCSV: doneWorksCSV,
        subject: subject,
        text: text,
        fileName: 'piececalc',
      );
    }
  }

  /// Pick and read file.
  Future<void> pickAndReadFile() async {
    final log = Logger('FilePickingBloc_pickAndReadFile');
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'], // Add more extensions if you want
      );

      if (result == null || result.files.isEmpty) {
        log.log(Level.INFO, 'No file picked');
        emit(state.copyWith(status: FilePickingStatus.noFilePicked));
        return;
      }

      final file = result.files.first;

      if (file.extension != 'csv') {
        log.log(Level.INFO, 'Picked a non-CSV file');
        emit(state.copyWith(status: FilePickingStatus.pickedOther));
        return;
      }

      String contents;

      if (!kIsWeb) {
        // For mobile platforms
        contents = await io.File(file.path!).readAsString();
      } else {
        // For web platform
        final fileReadStream = file.bytes;
        if (fileReadStream == null) {
          throw Exception('Cannot read file from null stream');
        }
        contents = utf8.decode(fileReadStream);
      }

      // Check the first line of the file
      if (contents.split('\n').first != firstLine) {
        log.log(Level.INFO, 'File is not correct');
        emit(state.copyWith(status: FilePickingStatus.fileIsNotBackup));
        return;
      }

      await restoreBackup(contents);
      emit(state.copyWith(status: FilePickingStatus.dataUploaded));
    } catch (e) {
      log.log(Level.INFO, 'Error, abort operation: $e');
      emit(state.copyWith(status: FilePickingStatus.fileIsNotBackup));
    } finally {
      emit(state.copyWith(status: FilePickingStatus.initial));
    }
  }

  /// Restore backup from [contents] String.
  Future<void> restoreBackup(String contents) async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');

    final worksDataList = <Map<String, dynamic>>[];
    final doneWorksDataList = <Map<String, dynamic>>[];

    // Split by lines
    final lines = contents.split('\n');

    // Find the index of the first set of two blank lines
    var blankLineIndex = -1;
    for (var i = 0; i < lines.length - 1; i++) {
      if (lines[i].isEmpty && lines[i + 1].isEmpty) {
        blankLineIndex = i;
        break;
      }
    }

    final worksLines = lines.sublist(0, blankLineIndex);
    final doneWorksLines = lines.sublist(blankLineIndex + 2); // Skip the two blank lines

// Parsing 'works'
    for (var i = 2; i < worksLines.length; i++) {
      final line = worksLines[i];
      final fields = line.split(','); // Note the tab separation
      final workData = {
        'id': fields[0],
        'workName': fields[1],
        'workType': fields[2],
        'price': double.parse(fields[3]),
        'orderIndex': int.parse(fields[4]),
        'workColor': int.parse(fields[5]),
        'isArchived': fields[6] == '1' ? 1 : 0,
      };
      worksDataList.add(workData);
    }

// Parsing 'done_works'
    for (var i = 2; i < doneWorksLines.length - 1; i++) {
      final line = doneWorksLines[i];
      final fields = line.split(','); // Note the tab separation
      final doneWorkData = {
        'id': fields[0],
        'workId': fields[1],
        'amount': fields[2],
        'dateCreated': fields[3],
        'comment': fields[4],
      };
      doneWorksDataList.add(doneWorkData);
    }

    // Insert all work data into the database
    await DatabaseOperations.insertDataBatch(db, 'works', worksDataList);
    await DatabaseOperations.insertDataBatch(db, 'done_works', doneWorksDataList);

    emit(state.copyWith(status: FilePickingStatus.dataUploaded));
    emit(state.copyWith(status: FilePickingStatus.initial));
  }
}
