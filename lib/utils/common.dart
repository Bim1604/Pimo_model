import 'package:intl/intl.dart';

String castAge(String date) {
  DateTime dateTime = DateTime.parse(date);
  int age = DateTime.now().year - dateTime.year;
  return age.toString() + ' years old';
}

DateTime parseDatetime(String date) {
  DateTime dt = DateTime.parse(date);
  return dt;
}

String formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  // var formatter = new DateFormat('EEEE, dd MMM, yyyy');
  var formatter = new DateFormat('dd MMM, yyyy');
  return formatter.format(dt);
}

String formatTime(String date) {
  DateTime dt = DateTime.parse(date);
  var formatter = new DateFormat('HH:mm');
  return formatter.format(dt);
}

String formatDateAndTime(String dateTime) {
  DateTime dt = DateTime.parse(dateTime);
  var formatter = new DateFormat('HH:mm - dd MMM, yyyy');
  return formatter.format(dt);
}

String formatCurrency(int salary) {
  final formatter = new NumberFormat.simpleCurrency(decimalDigits: 0);
  return formatter.format(salary);
}

String getCastingStatus(String openTime, String closeTime) {
  var d = new DateTime.now();
  return d.isBefore(DateTime.parse(openTime))
      ? 'Not Opened'
      : d.isAfter(DateTime.parse(closeTime))
      ? 'Closed'
      : 'Opening';
}