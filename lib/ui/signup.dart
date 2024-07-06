import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/Login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_2/respo/signupservice.dart'; // Import the Firestore service

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignupService _signupService = SignupService();

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
                    controller: _nameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,            // Enable the fill color
                      fillColor: Colors.white,
                      hintText: 'Name',
                      
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(

                    controller: _emailController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,            // Enable the fill color
                      fillColor: Colors.white,
                      hintText: 'Email',
                      
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,            // Enable the fill color
                      fillColor: Colors.white,
                      hintText: 'Password',
                      
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate the form
                        if (_formKey.currentState!.validate()) {
                          // If valid, retrieve input values
                          final String name = _nameController.text;
                          final String email = _emailController.text;
                          final String password = _passwordController.text;
                          await _signupService.addUser(name, email, password);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('User signed up successfully!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 16.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust radius as needed
                        ),
                      ),
                      child: Text(
                        'Signup',
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
                        text: 'Already have an account? ',
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
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'Login',
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
    // Basic email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
