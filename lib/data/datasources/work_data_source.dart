import 'package:piececalc/data/repositories/work_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../models/work.dart';

/// [WorkDataSource] serves as the concrete implementation of [WorkRepository].
///
/// It interacts directly with the provided database instance to fetch, store,
/// or update [Work] related data.
class WorkDataSource implements WorkRepository {
  /// Creates a new instance of [WorkDataSource].
  WorkDataSource(this.db);

  /// A reference to the SQLite [Database] instance that the data source will operate on.
  final Database db;

  @override
  Future<List<Work>> loadWorks() async {
    final List<Map<String, dynamic>> queryResult = await db.query(
      'works',
      orderBy: 'orderIndex ASC',
    );
    final savedWorks = queryResult.map(Work.fromJson).toList();
    return savedWorks;
  }
}
