import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Sign%20In.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  bool passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/a');
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign up',
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
                        'Create an Account, its free',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto-Black',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                          } else if (!value.endsWith('@gmail.com') && value.length > 10) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter Your password',
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
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Enter Your password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Builder(builder: (context) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade500,
                              elevation: 10,
                              minimumSize: const Size(370, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                final email = emailController.text;
                                final password = passwordController.text;
                                final name = usernameController.text;

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('name', name);
                                await prefs.setString('email', email);
                                await prefs.setString('password', password);
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  context.go('/d');
                                } else {
                                  const message = SnackBar(
                                    content: Text('Password not matched.'),
                                    duration: Duration(milliseconds: 1500),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(message);
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto-Black',
                                  fontWeight: FontWeight.w800),
                            ));
                      }),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontFamily: 'Roboto-Black',
                                fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/d');
                            },
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Login     ',
                              ),
                            ),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
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
          ),
        ],
      ),
    );
  }
}
