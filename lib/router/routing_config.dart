import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/DashBoard.dart';
import 'package:untitled/Home%20Screen.dart';
import 'package:untitled/Sign%20In.dart';
import 'package:untitled/Sign%20Up.dart';
import 'package:untitled/SplashScreen.dart';

class AppRoute {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/a",
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: "/b",
      builder: (BuildContext context, GoRouterState state) {
        return const DashBoard();
      },
    ),
    GoRoute(
      path: "/c",
      builder: (BuildContext context, GoRouterState state) {
        return SignUp();
      },
    ),
    GoRoute(
      path: "/d",
      builder: (BuildContext context, GoRouterState state) {
        return SignIn();
      },
    ),
    GoRoute(
      path: "/e",
      builder: (BuildContext context, GoRouterState state) {
        return DashBoard();
      },
    )
  ]);
}
