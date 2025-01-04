import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';

class DoctorDashboard extends StatefulWidget {
  final UserModel user;
  const DoctorDashboard({Key? key, required this.user}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Dashboard - ${widget.user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, Dr. ${widget.user.name}!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/doctorPatientList', arguments: widget.user);
              },
              child: const Text('View Patient List'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/doctorPrescriptionForm', arguments: widget.user);
              },
              child: const Text('Create Prescription'),
            ),
          ],
        ),
      ),
    );
  }
}
