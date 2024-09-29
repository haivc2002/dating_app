import 'package:intl/intl.dart';

String formatAmount(int value) {
  final formatter = NumberFormat("#,###");
  return formatter.format(value);
}