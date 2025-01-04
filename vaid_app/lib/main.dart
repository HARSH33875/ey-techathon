import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/screens/auth/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/patient/patient_dashboard.dart';
import 'presentation/screens/patient/patient_emergency_screen.dart';
import 'presentation/screens/doctor/doctor_dashboard.dart';
// Import other screens as needed
import 'data/models/user_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TravelingDoctorApp());
}

class TravelingDoctorApp extends StatelessWidget {
  const TravelingDoctorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traveling Doctor',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle named routes that need arguments
        if (settings.name == '/patientDashboard') {
          final user = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => PatientDashboard(user: user),
          );
        } else if (settings.name == '/doctorDashboard') {
          final user = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => DoctorDashboard(user: user),
          );
        } else if (settings.name == '/patientEmergency') {
          final user = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => PatientEmergencyScreen(user: user),
          );
        }
        // Add more routes as needed
        return null;
      },
    );
  }
}
