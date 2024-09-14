import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shaw_solutions/authentication.dart'; 
import 'firebase_options.dart';  // Import the generated Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the auto-generated options file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaw Solutions',
      home: AuthenticationScreen(),
    );
  }
}