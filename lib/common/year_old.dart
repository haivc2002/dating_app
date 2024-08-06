import 'package:intl/intl.dart';

int yearOld(String birthday) {
  if (birthday.isEmpty) {
    return 0;
  } else {
    try {
      DateTime birthDate = DateFormat('dd/MM/yyyy').parse(birthday);
      DateTime now = DateTime.now();
      int age = now.year - birthDate.year;

      if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }
}