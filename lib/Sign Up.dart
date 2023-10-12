import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  List<Map<String, String>> registeredUsers = [];
  @override
  void initState() {
    super.initState();
    loadRegisteredUsers();
  }

  void loadRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsersData = prefs.getStringList('registered_users');
    if (registeredUsersData != null) {
      registeredUsers = registeredUsersData.map((userData) {
        final userDataSplit = userData.split(':');
        return {
          'email': userDataSplit[0],
          'password': userDataSplit[1],
        };
      }).toList();
    }
  }

  void saveRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsersData = registeredUsers
        .map((user) => '${user['email']}:${user['password']}')
        .toList();
    prefs.setStringList('registered_users', registeredUsersData);
  }

  bool isEmailRegistered(String email) {
    return registeredUsers.any((user) => user['email'] == email);
  }

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
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 25,
                            ),
                            labelText: 'Username',
                            hintText: 'Enter Your Name',
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
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 25,
                            ),
                            hintText: 'Enter Your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (!value.endsWith('@gmail.com') ||
                              value.length < 10) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          obscureText: _obscurePassword,
                          obscuringCharacter: "*",
                          controller: passwordController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 25,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
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
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 25,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            labelText: 'Confirm Password',
                            hintText: 'Enter Your Password',
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
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                final email = emailController.text;
                                final password = passwordController.text;
                                final name = usernameController.text;
                                if (isEmailRegistered(email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Center(
                                        child: Text(
                                          'Email already registered',
                                          style: TextStyle(
                                            fontFamily: "Roboto-Black",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                      elevation: 6.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration:
                                          const Duration(milliseconds: 4500),
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                  );
                                } else {
                                  registeredUsers.add(
                                      {'email': email, 'password': password});
                                  saveRegisteredUsers();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('name', name);
                                  await prefs.setString('email', email);
                                  await prefs.setString('password', password);
                                  context.go('/d');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Center(
                                        child: Text(
                                          'Account Registration Successful',
                                          style: TextStyle(
                                            fontFamily: "Roboto-Black",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.green.shade700,
                                      elevation: 6.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Center(
                                      child: Text(
                                        'Password not the same as confirm password',
                                        style: TextStyle(
                                          fontFamily: "Roboto-Black",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.cyan,
                                    elevation: 6.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    padding: const EdgeInsets.all(16.0),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 27,
                                fontFamily: 'Roboto-Black',
                                fontWeight: FontWeight.w800),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto-Black',
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/d');
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Login  ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto-Black',
                                    fontWeight: FontWeight.w700),
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
