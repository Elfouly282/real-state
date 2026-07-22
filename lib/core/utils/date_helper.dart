/// Shared date-formatting utilities used across admin tables.
extension DateStringX on String {
  /// Returns only the date part (YYYY-MM-DD) from an ISO datetime string.
  String toDateOnly() => length > 10 ? substring(0, 10) : this;
}
