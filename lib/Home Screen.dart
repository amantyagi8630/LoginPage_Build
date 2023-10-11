import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'On Boarding',
            style: TextStyle(
                fontFamily: 'Roboto-Black',
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Hello There!",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                    fontFamily: 'Roboto-Black'),
              ),
              Image.asset('images/rocket-launch.png',height: 450,width: 300,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  elevation: 10,
                  minimumSize: Size(370, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onPressed: () {
                  context.push('/c');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto-Black',
                      fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade500,
                  elevation: 10,
                  minimumSize: Size(370, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onPressed: () {
                  context.push('/d');
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto-Black',
                      fontWeight: FontWeight.w700,
                  color: Colors.black),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
