import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isEmailVerified = false;
  bool _isSendingVerification = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _isEmailVerified = _user?.emailVerified ?? false;

    if (!_isEmailVerified) {
      _sendVerificationEmail();
    }
  }

  Future<void> _sendVerificationEmail() async {
    try {
      setState(() {
        _isSendingVerification = true;
      });
      await _user?.sendEmailVerification();
      setState(() {
        _isSendingVerification = false;
      });
    } catch (e) {
      setState(() {
        _isSendingVerification = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(e.toString())),
      // );
    }
  }

  Future<void> _checkEmailVerified() async {
    await _user?.reload();
    setState(() {
      _isEmailVerified = _auth.currentUser?.emailVerified ?? false;
    });
    if (_isEmailVerified) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email verified successfully')));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(index: 1,),
        ), // Replace with your main screen
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email not verified yet')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Email Verification'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Verify Your Email',
                  style: GoogleFonts.getFont(
                    'Lexend',
                    color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'A verification email has been sent to ${_user?.email}. Please check your inbox and verify your email.',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                if (_isSendingVerification)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _sendVerificationEmail,
                    child: Text('Resend Verification Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
                Text(
                  'After verifying your email, click the button below. I have verified my email',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _checkEmailVerified,
                  child: Text('I have verified my email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
