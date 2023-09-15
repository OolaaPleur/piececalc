import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents individual work added by a user.
///
/// Contains information about the work's ID, its name, its type (e.g., hourly or piecewise),
/// and the price associated with it. This class also provides utility methods
/// for JSON serialization and deserialization.
class Work extends Equatable {
  /// Creates a new instance of [Work].
  ///
  /// Requires [id], [workName], [paymentType], and [price] to be provided.
  const Work({required this.id, required this.workName, required this.paymentType, required this.price, required this.orderIndex, required this.workColor});

  /// Creates a new [Work] instance from a JSON map.
  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['id'].toString(),
      workName: json['workName'].toString(),
      paymentType: json['workType'].toString(),
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      orderIndex: int.tryParse(json['orderIndex'].toString()) ?? 0,
      workColor: Color(int.tryParse(json['workColor'] as String) ?? 0xFF2196F3),
    );
  }
  /// Unique identifier for the work.
  final String id;

  /// Name of the work.
  final String workName;

  /// Type of the work (e.g., "hourlyPayment" or "piecewisePayment").
  final String paymentType;

  /// Price associated with the work.
  final double price;
  final int orderIndex;
  final Color workColor;
  /// Converts the [Work] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workName': workName,
      'workType': paymentType,
      'price': price,
      'orderIndex': orderIndex,
      'workColor': workColor,
    };
  }

  @override
  List<Object> get props => [id, workName, paymentType, price, orderIndex, workColor];

  Work copyWith({
    String? id,
    String? workName,
    String? paymentType,
    double? price,
    int? orderIndex,
    Color? workColor,
  }) {
    return Work(
      id: id ?? this.id,
      workName: workName ?? this.workName,
      paymentType: paymentType ?? this.paymentType,
      price: price ?? this.price,
      orderIndex: orderIndex ?? this.orderIndex,
      workColor: workColor ?? this.workColor,
    );
  }
}
