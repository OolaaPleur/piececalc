import '../l10n/l10n.dart';

/// Work types by type of payment.
enum PaymentType {
  /// Payment per piece of work.
  piecewisePayment,
  /// Payment per hour of work.
  hourlyPayment
}

/// Themes of app.
enum AppTheme {
  /// Light theme.
  light,
  /// Dark theme.
  dark,
  /// System theme.
  auto
}

/// RegExp pattern to match valid numbers with a dot or comma.
final numericPattern = RegExp(r'^\d+([.,]?\d+)?$');

/// A mapping between language locale code, country emoji and enum values
/// and their respective localized string representations.
final Map<Map<String, String>, String Function(AppLocalizations)> languageToLocalKey = {
  {'en': '🇺🇸'}: (localizations) => localizations.english,
  {'et': '🇪🇪'}: (localizations) => localizations.estonian,
  {'ru': '🇷🇺'}: (localizations) => localizations.russian,
};

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
final Map<Month, String Function(AppLocalizations, int)> monthToLocalKey = {
  Month.january: (localizations, day) => localizations.january(day),
  Month.february: (localizations, day) => localizations.february(day),
  Month.march: (localizations, day) => localizations.march(day),
  Month.april: (localizations, day) => localizations.april(day),
  Month.may: (localizations, day) => localizations.may(day),
  Month.june: (localizations, day) => localizations.june(day),
  Month.july: (localizations, day) => localizations.july(day),
  Month.august: (localizations, day) => localizations.august(day),
  Month.september: (localizations, day) => localizations.september(day),
  Month.october: (localizations, day) => localizations.october(day),
  Month.november: (localizations, day) => localizations.november(day),
  Month.december: (localizations, day) => localizations.december(day),
};
/// Enum representing days of the week.
enum DaysOfWeek {
  /// Represents Monday.
  monday,
  /// Represents Tuesday.
  tuesday,
  /// Represents Wednedsday.
  wednesday,
  /// Represents Thursday.
  thursday,
  /// Represents Friday.
  friday,
  /// Represents Saturday.
  saturday,
  /// Represents Sunday.
  sunday
}

/// A mapping between [DaysOfWeek] enum values and their respective localized string representations.
final Map<DaysOfWeek, String Function(AppLocalizations)> daysOfWeekToLocalKey = {
  DaysOfWeek.monday: (localizations) => localizations.monday,
  DaysOfWeek.tuesday: (localizations) => localizations.tuesday,
  DaysOfWeek.wednesday: (localizations) => localizations.wednesday,
  DaysOfWeek.thursday: (localizations) => localizations.thursday,
  DaysOfWeek.friday: (localizations) => localizations.friday,
  DaysOfWeek.saturday: (localizations) => localizations.saturday,
  DaysOfWeek.sunday: (localizations) => localizations.sunday,
};
