import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter engine is initialized
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatefulWidget {
  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  bool updateRequiredshow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializedRemoteConfig();
  }

  Future<void> _initializedRemoteConfig() async {
    await _setRemoteConfig();
    bool isUpdateRequirednow = await isUpdateRequired();
    setState(() {
      updateRequiredshow = isUpdateRequirednow;
    });
  }

  Future<bool> isUpdateRequired() async {
    final _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.fetchAndActivate();

    final bool updateRequired = _remoteConfig.getBool('force_update');
    final String currentVersion = _remoteConfig.getString('current_version');
    final String appVersion = _remoteConfig.getString('app_version');

    // return true;
    return updateRequired && currentVersion.compareTo(appVersion) != 0;
  }

  Future<void> _setRemoteConfig() async {
    final _remoteConfig = FirebaseRemoteConfig.instance;
    // await _remoteConfig.setDefaults({'message': "Hello World!"});
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 10),
      ),
    );

    await _remoteConfig.fetchAndActivate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          displaySmall: TextStyle(color: Colors.black54),
        ),
      ),
      home: WelcomeScreen(),
      initialRoute: "welcome_screen",
      routes: {
        'welcome_screen': (context) =>
            updateRequiredshow ? ShowDialog() : WelcomeScreen(),
        'chat_screen': (context) => ChatScreen(),
        'login_screen': (context) => LoginScreen(),
      },
    );
  }
}

class ShowDialog extends StatelessWidget {
  void _openPlayStore() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blueAccent,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "An update is required!",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _openPlayStore();
                  // Navigate to App Store / Play Store
                },
                child: Text("Update Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
