import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../patient/patient_dashboard.dart';
import '../doctor/doctor_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // Fake splash delay

    User? currentUser = FirebaseAuthService.currentUser;
    if (currentUser != null) {
      // Fetch user details from Firestore
      final userDoc = await FirebaseAuthService.signInWithEmail(
        email: currentUser.email!,
        password: '', // We won't actually re-auth; just read user data
      );
      // If userDoc is found, route them based on role
      if (userDoc != null) {
        if (userDoc.role == 'doctor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DoctorDashboard(user: userDoc)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => PatientDashboard(user: userDoc)),
          );
        }
      } else {
        // If there's no doc, go to login
        _goToLogin();
      }
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Traveling Doctor App')),
    );
  }
}
