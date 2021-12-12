import 'package:flutter/material.dart';
import 'package:test_task/model/car.dart';

class CarElement extends StatelessWidget {
  final Car car;

  CarElement({required this.car});

  @override
  Widget build(BuildContext context) {
    String status = 'status: ';
    return InkWell(
      onTap: () {
        AlertDialog alert = AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CLOSE',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          title: Container(
            width: 656,
            height: 214,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    car.number.toString(),
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    status + car.state,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    car.date,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 267,
        height: 69,
        color: _getStateColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              car.number.toString(),
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                car.date,
                style: TextStyle(color: Colors.blue[900], fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStateColor() {
    switch (car.state) {
      case 'hidden':
        return Colors.blue.shade100;
      case 'available':
        return Colors.green.shade200;
      case 'disabled':
        return Colors.yellow.shade200;
      default:
        return Colors.green.shade200;
    }
  }
}
