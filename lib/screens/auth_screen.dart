import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'home_screen.dart';
import 'admin_home_screen.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String _verificationId = '';
  String _selectedRole = 'User'; // Default role

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_selectedRole == 'Admin') {
          // Admin login check
          if (_emailController.text == 'admin@gmail.com' && _passwordController.text == 'admin@123') {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => AdminHomeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Invalid admin credentials',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
            );
          }
        } else {
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
        }
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

  Future<void> _signInWithGoogle() async {
    if (_selectedRole == 'Admin') {
      Fluttertoast.showToast(
        msg: 'Google sign-in is disabled for Admin',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

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
      Fluttertoast.showToast(
        msg: 'Google sign-in failed: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyPhoneNumber() async {
    if (_selectedRole == 'Admin') {
      Fluttertoast.showToast(
        msg: 'Phone sign-in is disabled for Admin',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

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
                          ListTile(
                            title: Text('User'),
                            leading: Radio<String>(
                              value: 'User',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('Admin'),
                            leading: Radio<String>(
                              value: 'Admin',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
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
                  if (_selectedRole == 'User') ...[
                    Text('or'),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text('Sign in with Google'),
                      onPressed: _signInWithGoogle,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _verifyPhoneNumber,
                      child: Text('Sign in with Phone Number'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
