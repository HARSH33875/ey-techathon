import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';

class PatientDashboard extends StatefulWidget {
  final UserModel user;
  const PatientDashboard({Key? key, required this.user}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard - ${widget.user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, ${widget.user.name}!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patientEmergency', arguments: widget.user);
              },
              child: const Text('Emergency Call'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patientPrescriptions', arguments: widget.user);
              },
              child: const Text('View Prescriptions'),
            ),
          ],
        ),
      ),
    );
  }
}
