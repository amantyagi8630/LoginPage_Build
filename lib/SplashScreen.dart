import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/DashBoard.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      checkUserStatus();
    });
  }
  Future<void> checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (email != null && password != null) {
      context.go('/b');
    } else {
      context.go('/a');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
                child: Text(
              'Welcome',
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,fontFamily: 'Roboto-Black'),
            )),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
        ),
    );
  }
}
