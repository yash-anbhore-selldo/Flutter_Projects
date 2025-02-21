import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  String? email;
  final _auth = FirebaseAuth.instance;
  var fireuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefval) {
      setState(() {
        prefs = prefval;
      });
    });

    getData();
  }

  void getData() async {
    fireuser = _auth.currentUser;

    email = fireuser.email;
  }

  void logoutUser() async {
    prefs.clear();

    reDirectTo(context, () => WelcomeScreen("data"), state: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () => reDirectTo(context, () => ChatScreen()),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () => reDirectTo(context, () => ProfileScreen()),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Logout'),
              onTap: () => logoutUser(),
            ),
          ],
        )),
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                Text(
                  email ?? "Loading...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
