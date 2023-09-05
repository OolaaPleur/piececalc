import '../l10n/l10n.dart';

/// Work types by type of payment.
enum PaymentType {
  /// Payment per piece of work.
  piecewisePayment,
  /// Payment per hour of work.
  hourlyPayment
}
/// Horizontal padding for text field.
const textFieldHorizontalPadding = 20.0;
/// Vertical padding for text field.
const textFieldVerticalPadding = 10.0;

/// RegExp pattern to match valid numbers with a dot or comma.
final numericPattern = RegExp(r'^\d+([.,]?\d+)?$');

/// Enum representing the months of the year.
enum Month {
  /// Represents the month of January.
  january,
  /// Represents the month of February.
  february,
  /// Represents the month of March.
  march,
  /// Represents the month of April.
  april,
  /// Represents the month of May.
  may,
  /// Represents the month of June.
  june,
  /// Represents the month of July.
  july,
  /// Represents the month of August.
  august,
  /// Represents the month of September.
  september,
  /// Represents the month of October.
  october,
  /// Represents the month of November.
  november,
  /// Represents the month of December.
  december
}
/// A mapping between [Month] enum values and their respective localized string representations.
final Map<Month, String Function(AppLocalizations)> monthToLocalKey = {
  Month.january: (localizations) => localizations.january,
  Month.february: (localizations) => localizations.february,
  Month.march: (localizations) => localizations.march,
  Month.april: (localizations) => localizations.april,
  Month.may: (localizations) => localizations.may,
  Month.june: (localizations) => localizations.june,
  Month.july: (localizations) => localizations.july,
  Month.august: (localizations) => localizations.august,
  Month.september: (localizations) => localizations.september,
  Month.october: (localizations) => localizations.october,
  Month.november: (localizations) => localizations.november,
  Month.december: (localizations) => localizations.december,
};
