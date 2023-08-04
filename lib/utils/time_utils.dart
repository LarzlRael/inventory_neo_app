part of 'utils.dart';

const months = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
];
String literalDate(DateTime date) {
  Moment rawDate = Moment(date);
  return rawDate.format("dd-MM-yyyy");
}

String literalDateWithMount(DateTime date) {
  Moment rawDate = Moment(date);
  return "${rawDate.format("d")} de ${months[rawDate.month - 1]} del ${rawDate.format("y")}";
}
