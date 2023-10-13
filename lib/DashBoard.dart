import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Sign%20In.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key});

  Future<void> logOutAndClearCredentials(BuildContext context,
      {bool deleteAccount = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (deleteAccount) {
      String? email = prefs.getString('email');

      List<String>? registeredUsersData =
          prefs.getStringList('registered_users');
      if (registeredUsersData != null) {
        registeredUsersData
            .removeWhere((userData) => userData.split(':')[1] == email);
        prefs.setStringList('registered_users', registeredUsersData);
      }
    }

    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('password');

    if (deleteAccount)
    {
      SignIn.hasSignedIn = false;
      context.go('/a');
    } else {
      SignIn.hasSignedIn = false;
      context.go('/a');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'My Da',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'shb',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'oard',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 28,
                  fontFamily: 'Roboto-Black',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: Image.asset('images/rocket-launch.png').image,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final prefs = snapshot.data!;
            final name = prefs.getString('name');
            final email = prefs.getString('email');

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0C187A),
                    Color(0xFF030F56),
                    Color(0xFF019CDF),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      name ?? 'Your Name',
                      style: const TextStyle(fontSize: 20),
                    ),
                    accountEmail: Text(
                      email ?? 'your@gmail.com',
                      style: const TextStyle(fontSize: 18),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          Image.asset('images/rocket-launch.png').image,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    title: const Text('Dashboard',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto-Black',
                            fontWeight: FontWeight.w600,
                            color: Colors.green)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto-Black',
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                    onTap: () {
                      logOutAndClearCredentials(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Delete Account',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto-Black',
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    onTap: () {
                      logOutAndClearCredentials(context, deleteAccount: true);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0C187A),
              Color(0xFF030F56),
              Color(0xFF019CDF),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}
