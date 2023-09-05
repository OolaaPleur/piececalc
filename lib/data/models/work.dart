import 'package:equatable/equatable.dart';

/// Represents individual work added by a user.
///
/// Contains information about the work's ID, its name, its type (e.g., hourly or piecewise),
/// and the price associated with it. This class also provides utility methods
/// for JSON serialization and deserialization.
class Work extends Equatable {
  /// Creates a new instance of [Work].
  ///
  /// Requires [id], [workName], [paymentType], and [price] to be provided.
  const Work({required this.id, required this.workName, required this.paymentType, required this.price});

  /// Creates a new [Work] instance from a JSON map.
  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['id'].toString(),
      workName: json['workName'].toString(),
      paymentType: json['workType'].toString(),
      price: json['price'].toString(),
    );
  }
  /// Unique identifier for the work.
  final String id;

  /// Name of the work.
  final String workName;

  /// Type of the work (e.g., "hourlyPayment" or "piecewisePayment").
  final String paymentType;

  /// Price associated with the work.
  final String price;
  /// Converts the [Work] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workName': workName,
      'workType': paymentType,
      'price': price,
    };
  }

  @override
  List<Object> get props => [id, workName, paymentType, price];
}
