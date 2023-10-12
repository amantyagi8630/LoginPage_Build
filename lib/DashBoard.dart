import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key});

  // Function to log out and clear credentials
  Future<void> logOutAndClearCredentials(BuildContext context) async {
    // Clear stored data (logout)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    // Retrieve the list of registered users from SharedPreferences
    List<String>? registeredUsersData = prefs.getStringList('registered_users');
    if (registeredUsersData != null) {
      // Convert the list of user data into a list of maps
      List<Map<String, String>> registeredUsers =
          registeredUsersData.map((userData) {
        final userDataSplit = userData.split(':');
        return {
          'name': userDataSplit[0],
          'email': userDataSplit[1],
          'password': userDataSplit[2],
        };
      }).toList();

      // Find and remove the current user's data from the list
      registeredUsers.removeWhere((user) =>
          user['name'] == name &&
          user['email'] == email &&
          user['password'] == password);

      // Save the updated list back to SharedPreferences
      prefs.setStringList(
        'registered_users',
        registeredUsers
            .map((user) =>
                '${user['name']}:${user['email']}:${user['password']}')
            .toList(),
      );
    }

    // Remove the current user's email and password from SharedPreferences
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('password');

    // Navigate to the desired route, for example, '/a'
    context.go('/a');
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
            onPressed: () {
              // Add action for the rightmost icon here
            },
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
              return CircularProgressIndicator();
            }

            final prefs = snapshot.data!;
            final name = prefs.getString('name');
            final email = prefs.getString('email');

            return Container(
              decoration: BoxDecoration(
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
                      style: TextStyle(fontSize: 20),
                    ),
                    accountEmail: Text(
                      email ?? 'your@gmail.com',
                      style: TextStyle(fontSize: 18),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          Image.asset('images/rocket-launch.png').image,
                    ),
                    decoration: BoxDecoration(
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
                    child:
                        Container(), // Empty container to push items to the bottom
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
                      logOutAndClearCredentials(
                          context); // Call the logout function
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
                      logOutAndClearCredentials(
                          context); // Call the clear credentials function
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
        decoration: BoxDecoration(
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
