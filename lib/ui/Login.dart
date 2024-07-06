import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_2/respo/loginservice.dart';
import 'package:flutter_application_2/ui/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Form key for managing form state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    'Comments',
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,            // Enable the fill color
                      fillColor: Colors.white,
                      hintText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(

                      alignLabelWithHint: true,
                      filled: true,
                      hintText: 'Password',
                      fillColor: Colors.white,  // Set the fill color to white
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.33),
                  SizedBox(
                    width: double.infinity,
                    height: 53.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          final String email = _emailController.text;
                          final String password = _passwordController.text;

                          User? user = await _authService.signInWithEmailAndPassword(email, password);

                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful!')),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Homepage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login failed. Please check your credentials.')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 15.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'New Here? ',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignupPage()),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
