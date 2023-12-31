import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/screens/auth/auth_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/auth',
      getPages: [
        GetPage(
          name: '/auth',
          page: () => AuthScreen(),
        ),
      ],
    );
  }
}
