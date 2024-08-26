extension DateTimeExtention on String {
  int toInt() => int.parse(this);
  double toFloat() => double.parse(this);
  DateTime toDateTime() => DateTime.parse(this);

  String pluralize(int length) {
    if (length == 1) return this;
    return "${this}s";
  }

  String titleCaseSingle() => '${this[0].toUpperCase()}${substring(1)}';

  String defaultOnEmpty([String defaultValue = ""]) =>
      isEmpty ? defaultValue : this;
}

String getFormattedDate(DateTime? date) {
  if (date == null) {
    return '';
  }
  final dateTime = date.toIso8601String();
  final dateTimeSplit = dateTime.split('T');

  var dateSplitFirst = dateTimeSplit.first.split('-');
  final finalDate = '${dateSplitFirst[1]}/${dateSplitFirst[2]}';

  dateSplitFirst = dateTimeSplit[1].split(':');
  final finalTime = '${dateSplitFirst[0]}:${dateSplitFirst[1]}';

  return '$finalDate $finalTime';
}
