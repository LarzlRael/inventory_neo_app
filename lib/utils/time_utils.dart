part of 'utils.dart';

String literalDate(DateTime date) {
  Moment rawDate = Moment.fromDate(date);
  return rawDate.format("dd-MM-yyyy");
}
