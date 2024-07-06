import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_2/ui/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDp73Ut6sxBZseywtmfrENGEHqJ_n_Q4Ho',
    appId: '1:905821069699:android:13c1a22daf6f8eb6f0d6b6',
    messagingSenderId: '905821069699',
    projectId: 'st-john-s-2ca4e',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 868),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => const MaterialApp(
        title: 'My App',
        home: SignupPage(),
      ),
    );
  }
}
