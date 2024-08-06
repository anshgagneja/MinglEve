import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      } on FirebaseAuthException catch (e) {
        String message = 'An error occurred, please try again';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyPhoneNumber() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _phoneNumberController = TextEditingController();
        PhoneNumber number = PhoneNumber(isoCode: 'US');

        return AlertDialog(
          title: Text('Enter Phone Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber phoneNumber) {
                  number = phoneNumber;
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: _phoneNumberController,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = true;
                });
                String phoneNumber = number.phoneNumber!;
                await _auth.verifyPhoneNumber(
                  phoneNumber: phoneNumber,
                  verificationCompleted: (PhoneAuthCredential credential) async {
                    await _auth.signInWithCredential(credential);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    Fluttertoast.showToast(
                      msg: 'Verification failed: ${e.message}',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      _verificationId = verificationId;
                      _isLoading = false;
                    });

                    _showOtpDialog();
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {
                    setState(() {
                      _verificationId = verificationId;
                    });
                  },
                );
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showOtpDialog() async {
    final _otpController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            controller: _otpController,
            decoration: InputDecoration(
              labelText: 'OTP',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final credential = PhoneAuthProvider.credential(
                  verificationId: _verificationId,
                  smsCode: _otpController.text,
                );

                try {
                  await _auth.signInWithCredential(credential);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: 'Invalid OTP',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          _isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: _login,
                                  child: Text('Login'),
                                ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signUp'); // Navigate to the sign-up screen
                            },
                            child: Text('Create an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('or'),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text('Sign in with Google'),
                    onPressed: () {
                      // Implement Google sign-in
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyPhoneNumber,
                    child: Text('Sign in with Phone Number'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
