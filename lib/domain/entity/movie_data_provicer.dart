DateTime? parseDateFromString(String? date) {
  if (date == null || date.isEmpty) return null;
  return DateTime.tryParse(date);
}
