import 'package:intl/intl.dart';

class Car {
  final int number;
  final String date;
  final String state;
  Car({required this.number, required this.date, required this.state});

  factory Car.fromJson(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json['date']);
    return Car(
      number: json['number'],
      date: DateFormat('HH:mm:ss yy.MM.dd').format(dateTime),
      state: json['state'],
    );
  }
  @override
  String toString() {
    return 'number:($number) date:($date) state:($state)';
  }
}
