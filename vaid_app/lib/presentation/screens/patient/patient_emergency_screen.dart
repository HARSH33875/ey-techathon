import 'package:flutter/material.dart';
import '../../../data/services/emergency_service.dart';
import '../../../data/services/location_service.dart';
import '../../../data/models/user_model.dart';
import 'package:geolocator/geolocator.dart';

class PatientEmergencyScreen extends StatefulWidget {
  final UserModel user;
  const PatientEmergencyScreen({Key? key, required this.user}) : super(key: key);

  @override
  _PatientEmergencyScreenState createState() => _PatientEmergencyScreenState();
}

class _PatientEmergencyScreenState extends State<PatientEmergencyScreen> {
  bool _isLoading = false;
  String _statusMessage = '';

  void _callEmergency() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });
    try {
      Position position = await LocationService.getCurrentLocation();
      bool success = await EmergencyService.callEmergency(
        patientId: widget.user.id,
        token: widget.user.token,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      setState(() {
        _isLoading = false;
        _statusMessage = success ? 'Emergency Call Sent!' : 'Emergency Call Failed!';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
      ),
      body: Center(
        child: _isLoading 
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _callEmergency,
                  child: const Text('Call Nearest Doctor'),
                ),
                if (_statusMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_statusMessage),
                  ),
              ],
            ),
      ),
    );
  }
}
