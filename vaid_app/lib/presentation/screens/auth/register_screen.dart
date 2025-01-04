import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/models/user_model.dart';
import '../../../config/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = AppConstants.rolePatient; // default selection
  bool _isLoading = false;
  String _errorMessage = '';

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final user = await AuthService.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: _role,
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      // Navigate to appropriate dashboard
      if (user.role == AppConstants.roleDoctor) {
        Navigator.pushReplacementNamed(context, '/doctorDashboard', arguments: user);
      } else {
        Navigator.pushReplacementNamed(context, '/patientDashboard', arguments: user);
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
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty) 
              Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text('Register'),
                    onPressed: _register,
                  ),
          ],
        ),
      ),
    );
  }
}
