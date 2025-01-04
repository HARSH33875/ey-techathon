import 'package:flutter/material.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../../../config/constants.dart';
import '../doctor/doctor_dashboard.dart';
import '../patient/patient_dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = AppConstants.rolePatient;
  bool _isLoading = false;
  String _errorMessage = '';

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final userModel = await FirebaseAuthService.registerWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      role: _role,
    );

    setState(() => _isLoading = false);

    if (userModel != null) {
      // Navigate based on role
      if (userModel.role == AppConstants.roleDoctor) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DoctorDashboard(user: userModel)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PatientDashboard(user: userModel)),
        );
      }
    } else {
      setState(() {
        _errorMessage = 'Registration failed. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButton<String>(
              value: _role,
              items: [
                DropdownMenuItem(
                  value: AppConstants.rolePatient,
                  child: const Text('Patient'),
                ),
                DropdownMenuItem(
                  value: AppConstants.roleDoctor,
                  child: const Text('Doctor'),
                ),
              ],
              onChanged: (val) {
                setState(() {
                  _role = val ?? AppConstants.rolePatient;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty) 
              Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}