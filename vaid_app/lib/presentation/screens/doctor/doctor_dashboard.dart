import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import 'doctor_patient_list_screen.dart';
import 'doctor_prescription_form_screen.dart';

class DoctorDashboard extends StatelessWidget {
  final UserModel user;
  const DoctorDashboard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard - ${user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, Dr. ${user.name}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DoctorPatientListScreen(user: user)),
                );
              },
              child: const Text('View Patient List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DoctorPrescriptionFormScreen(user: user)),
                );
              },
              child: const Text('Create Prescription'),
            ),
          ],
        ),
      ),
    );
  }
}