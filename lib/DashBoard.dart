import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                ),
                Icon(
                  Icons.broadcast_on_home,
                  size: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                // home_page.dart

                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate back to sign-in page
                        context.go('/a');
                      },
                      child: Text('Logout'),
                    ),
                    SizedBox(height: 30,),
                    Text('Want to clear credentials press below button',style: TextStyle(color: Colors.black),),
                    SizedBox(height: 30,),
                    // home_page.dart

                    ElevatedButton(
                      onPressed: () async {
                        // Clear stored data (logout)
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('email');
                        prefs.remove('password');

                        // Navigate back to sign-in page
                        context.go('/a');
                      },
                      child: Text('Clear Credentials'),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
