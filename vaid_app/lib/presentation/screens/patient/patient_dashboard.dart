import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import 'patient_emergency_screen.dart';
import 'patient_prescriptions_screen.dart';

class PatientDashboard extends StatelessWidget {
  final UserModel user;
  const PatientDashboard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard - ${user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, ${user.name}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PatientEmergencyScreen(user: user)),
                );
              },
              child: const Text('Emergency Call'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PatientPrescriptionsScreen(user: user)),
                );
              },
              child: const Text('View Prescriptions'),
            ),
          ],
        ),
      ),
    );
  }
}