import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/prescription_model.dart';
import '../../../data/services/firebase_db_service.dart';

class PatientPrescriptionsScreen extends StatefulWidget {
  final UserModel user;
  const PatientPrescriptionsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _PatientPrescriptionsScreenState createState() => _PatientPrescriptionsScreenState();
}

class _PatientPrescriptionsScreenState extends State<PatientPrescriptionsScreen> {
  List<PrescriptionModel> _prescriptions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrescriptions();
  }

  Future<void> _fetchPrescriptions() async {
    final data = await FirebaseDBService.getPatientPrescriptions(widget.user.uid);
    setState(() {
      _prescriptions = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prescriptions'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _prescriptions.isEmpty
              ? const Center(child: Text('No prescriptions found.'))
              : ListView.builder(
                  itemCount: _prescriptions.length,
                  itemBuilder: (context, index) {
                    final pres = _prescriptions[index];
                    return ListTile(
                      title: Text(pres.description),
                      subtitle: Text('Prescribed by: ${pres.doctorId}'),
                    );
                  },
                ),
    );
  }
}
