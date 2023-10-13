import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required List registeredUsers}) : super(key: key);
  static bool hasSignedIn = false;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String registeredUserName = '';
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      decoration: TextDecoration.none,
      decorationThickness: 0,
      fontFamily: 'Roboto-Black',
      fontWeight: FontWeight.w800,
      letterSpacing: 0.8,
    );
    OutlineInputBorder myEnabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 2.5),
      borderRadius: BorderRadius.circular(25),
    );
    OutlineInputBorder myFocusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blue, width: 2.5),
      borderRadius: BorderRadius.circular(25),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/a');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0C187A), Color(0xFF030F56), Color(0xFF019CDF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(),
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
                        letterSpacing: 0.8,
                        fontFamily: 'Roboto-Black',
                        fontWeight: FontWeight.w800,
                        fontSize: 35,
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Welcome back! Login with your credentials',
                      style: TextStyle(
                        fontFamily: 'Roboto-Black',
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: myTextStyle,
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        labelStyle: myTextStyle,
                        hintStyle: myTextStyle,
                        enabledBorder: myEnabledBorder,
                        focusedBorder: myFocusedBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: myTextStyle,
                      obscureText: _obscurePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          color: Colors.white,
                          Icons.lock,
                          size: 25,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.white,
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
                        enabledBorder: myEnabledBorder,
                        focusedBorder: myFocusedBorder,
                        labelStyle: myTextStyle,
                        hintStyle: myTextStyle,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Minimum length required is 8 characters';
                        } else if (value.length > 14) {
                          return 'Maximum length allowed is 14 characters';
                        } else if (!RegExp(
                                r'^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).+$')
                            .hasMatch(value)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
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

                            bool isAuthenticated = await authenticateUser(
                                enteredEmail, enteredPassword);

                            if (isAuthenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Welcome Back $registeredUserName',
                                      style: const TextStyle(
                                        fontFamily: "Roboto-Black",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.green.shade500,
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 1500),
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              );
                              SignIn.hasSignedIn = true;
                              context.go('/e');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Center(
                                    child: Text(
                                      'User account not found!',
                                      style: TextStyle(
                                        fontFamily: "Roboto-Black",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 1500),
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 0.8,
                              fontFamily: 'Roboto-Black'),
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "'Don't have an account'",
                          style: TextStyle(
                            fontFamily: 'Roboto-Black',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/c');
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
                              ' Sign Up',
                              style: TextStyle(fontSize: 15),
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
      ),
    );
  }

  Future<bool> authenticateUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsersData = prefs.getStringList('registered_users');
    if (registeredUsersData != null) {
      for (var userData in registeredUsersData) {
        final userDataSplit = userData.split(':');
        final storedEmail = userDataSplit[1];
        final storedPassword = userDataSplit[2];
        final storedName = userDataSplit[0];

        if (storedEmail == email && storedPassword == password) {
          setState(() {
            registeredUserName = storedName;
          });
          return true;
        }
      }
    }
    return false;
  }
}
