import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/DashBoard.dart';
import 'package:untitled/Sign%20Up.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/a');
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        decoration: const BoxDecoration(
            ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Roboto-Black',
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Welcome back! Login with your credentials',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto-Black',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else if (!value.endsWith('@gmail.com')) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'minimum length required 8 characters';
                      } else if (value.length > 14) {
                        return 'maximum length required 14 characters';
                      } else if (!RegExp(
                              r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).+$')
                          .hasMatch(value)) {
                        return 'Please enter a valid password';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        elevation: 10,
                        minimumSize: const Size(370, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          final enteredEmail = emailController.text;
                          final enteredPassword = passwordController.text;

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final storedEmail = prefs.getString('email');
                          final storedPassword = prefs.getString('password');

                          if (enteredEmail == storedEmail &&
                              enteredPassword == storedPassword) {
                            context.go('/e');
                          } else {
                            const message = SnackBar(
                              content: Text(
                                  'Please enter valid email id & password'),
                              duration: Duration(milliseconds: 1500),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(message);
                          }
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ));
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account',
                      style: TextStyle(
                          fontFamily: 'Roboto-Black',
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/c');
                      },
                      child: const Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Sign Up    ',
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
