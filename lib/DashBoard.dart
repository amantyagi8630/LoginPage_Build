import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 350,
              ),
              const Icon(
                Icons.broadcast_on_home,
                size: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate back to sign-in page
                      context.go('/a');
                    },
                    child: const Text('Logout'),
                  ),
                  const SizedBox(height: 30,),
                  const Text('Want to clear credentials, press below button', style: TextStyle(color: Colors.black),),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () async {
                      // Clear stored data (logout)
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? email = prefs.getString('email');
                      String? password = prefs.getString('password');

                      // Remove the current user's email and password from the list
                      List<Map<String, String>> registeredUsers = [];
                      List<String>? registeredUsersData = prefs.getStringList('registered_users');
                      if (registeredUsersData != null) {
                        registeredUsers = registeredUsersData.map((userData) {
                          final userDataSplit = userData.split(':');
                          return {
                            'email': userDataSplit[0],
                            'password': userDataSplit[1],
                          };
                        }).toList();

                        // Remove the current user's data from the list
                        registeredUsers.removeWhere((user) =>
                        user['email'] == email && user['password'] == password);

                        // Save the updated list
                        prefs.setStringList('registered_users', registeredUsers
                            .map((user) => '${user['email']}:${user['password']}')
                            .toList());
                      }

                      // Remove the current user's email and password from SharedPreferences
                      prefs.remove('email');
                      prefs.remove('password');

                      context.go('/a');
                    },
                    child: const Text('Clear Credentials'),
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
