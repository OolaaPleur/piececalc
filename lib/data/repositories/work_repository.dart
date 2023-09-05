// ignore_for_file: one_member_abstracts

import '../models/work.dart';

/// Represents an abstract definition for a repository responsible for handling `Work` operations.
///
/// Concrete implementations of this class should provide specific data source
/// operations like fetching, storing, or updating `Work` related data.
abstract class WorkRepository {

  /// Retrieves a list of all `Work` objects from the data source.
  ///
  /// Returns:
  /// - A `Future` that completes with a list of [Work] objects.
  Future<List<Work>> loadWorks();
}
