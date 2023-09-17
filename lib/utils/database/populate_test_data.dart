import 'package:sqflite/sqflite.dart';

import 'database_operations.dart';

/// Populate dev version of an app with values.
class PopulateTestData {
  /// Populates the database with test data.
  Future<void> populateTestData() async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    final batch = db.batch();
    // Data for the 'works' table
    final worksData = <Map<String, dynamic>>[
      {
        'id': 'test_work_id_1',
        'workName': 'Piece',
        'workType': 'piecewisePayment',
        'price': '2',
        'orderIndex': '1',
        'workColor': '0xFFFF0000',
        'isArchived': 0,
      },
      {
        'id': 'test_work_id_2',
        'workName': 'Hour',
        'workType': 'hourlyPayment',
        'price': '3',
        'orderIndex': '2',
        'workColor': '0xFF00FF00',
        'isArchived': 0,
      },
      {
        'id': 'test_work_id_3',
        'workName': 'HourArchived',
        'workType': 'hourlyPayment',
        'price': '4',
        'orderIndex': '3',
        'workColor': '0xFF4BC580',
        'isArchived': 1,
      },
      {
        'id': 'test_work_id_4',
        'workName': 'PieceArchived',
        'workType': 'piecewisePayment',
        'price': '5',
        'orderIndex': '4',
        'workColor': '0xFFBD6D97',
        'isArchived': 1,
      },
      {
        'id': 'test_work_id_5',
        'workName': 'Hour2',
        'workType': 'hourlyPayment',
        'price': '5',
        'orderIndex': '4',
        'workColor': '0xFF1A1FC6',
        'isArchived': 0,
      },
      {
        'id': 'test_work_id_6',
        'workName': 'Piece2',
        'workType': 'piecewisePayment',
        'price': '5',
        'orderIndex': '4',
        'workColor': '0xFFB5EE70',
        'isArchived': 0,
      },
    ];

    // Insert items into 'works' table using batch
    for (final work in worksData) {
      final exists = await _recordExists(db, 'works', work['id'] as String);
      if (!exists) {
        batch.insert('works', work);
      }
    }

    // Data for the 'done_works' table
    final doneWorksData = <Map<String, dynamic>>[
      {
        'id': 'test_done_work_id_1',
        'workId': 'test_work_id_1',
        'amount': '5',
        'dateCreated': '2023-09-15',
        'comment': 'comment for first task'
      ,},
      {
        'id': 'test_done_work_id_2',
        'workId': 'test_work_id_1',
        'amount': '10',
        'dateCreated': '2023-09-14',
        'comment': 'comment for second task'
        ,},
      {
        'id': 'test_done_work_id_3',
        'workId': 'test_work_id_2',
        'amount': '2:00',
        'dateCreated': '2023-09-15',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_4',
        'workId': 'test_work_id_2',
        'amount': '1:15',
        'dateCreated': '2023-09-14',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_5',
        'workId': 'test_work_id_3',
        'amount': '4:37',
        'dateCreated': '2023-09-13',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_6',
        'workId': 'test_work_id_4',
        'amount': '14',
        'dateCreated': '2023-09-12',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_7',
        'workId': 'test_work_id_4',
        'amount': '16',
        'dateCreated': '2023-09-11',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_8',
        'workId': 'test_work_id_5',
        'amount': '5:05',
        'dateCreated': '2023-09-10',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_9',
        'workId': 'test_work_id_5',
        'amount': '0:45',
        'dateCreated': '2023-09-12',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_10',
        'workId': 'test_work_id_5',
        'amount': '2:20',
        'dateCreated': '2023-09-14',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_11',
        'workId': 'test_work_id_6',
        'amount': '10',
        'dateCreated': '2023-09-12',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_12',
        'workId': 'test_work_id_6',
        'amount': '20',
        'dateCreated': '2023-09-15',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_13',
        'workId': 'test_work_id_6',
        'amount': '3',
        'dateCreated': '2023-09-12',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_14',
        'workId': 'test_work_id_6',
        'amount': '7',
        'dateCreated': '2023-09-13',
        'comment': '',
      },
      {
        'id': 'test_done_work_id_15',
        'workId': 'test_work_id_6',
        'amount': '12',
        'dateCreated': '2023-09-11',
        'comment': '',
      },
    ];

    // Insert items into 'done_works' table using batch
    for (final doneWork in doneWorksData) {
      final exists = await _recordExists(db, 'done_works', doneWork['id'] as String);
      if (!exists) {
        batch.insert('done_works', doneWork);
      }
    }

    // Commit the batch
    await batch.commit(noResult: true);
  }
  Future<bool> _recordExists(Database db, String tableName, String id) async {
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
