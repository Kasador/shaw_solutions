import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String _verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Enter phone number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Send Code'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Enter verification code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send verification code
  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        print('User signed in automatically.');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        print('Code sent to phone.');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  // Function to sign in with verification code
  void _signInWithPhoneNumber() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _codeController.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      print('User signed in successfully.');
      // Navigate to client portal or another screen
    } catch (e) {
      print('Error signing in: $e');
    }
  }
}