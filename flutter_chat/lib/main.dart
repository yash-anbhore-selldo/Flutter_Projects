import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/profile_screen.dart';
import 'package:flutter_chat/screens/splash_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

bool showApp = false;

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
  bool isloggedin = false;
  bool updateRequiredshow = false;
  String data = '';
  bool? checklogin = false;

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checklogin = prefs.getBool('isLoggedIn');
    if (checklogin!) {
      isloggedin = true;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          );
        }
      });
    });
    checkLogin();
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
    data = appVersion;

    return updateRequired && currentVersion.compareTo(appVersion) != 0;
  }

  Future<void> _setRemoteConfig() async {
    final _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 3),
        minimumFetchInterval: Duration(seconds: 3),
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
      // home: updateRequiredshow && !showApp ? ShowDialog() : WelcomeScreen(data),
      home: SplashScreen(),

      initialRoute: "splash",
      routes: {
        'welcome_screen': (context) =>
            isloggedin ? ChatScreen() : WelcomeScreen(data),
        // updateRequiredshow && !showApp ? ShowDialog() : WelcomeScreen(data),
        'chat_screen': (context) => ChatScreen(),
        'splash': (context) => SplashScreen(),
        'login_screen': (context) => LoginScreen(),
        'profile_screen': (context) => ProfileScreen(),
      },
    );
  }
}

// class ShowDialog extends StatefulWidget {
//   @override
//   State<ShowDialog> createState() => _ShowDialogState();
// }
//
// class _ShowDialogState extends State<ShowDialog> {
//   void _openPlayStore() async {
//     setState(() {
//       showApp = true;
//     });
//     // Uncomment the following lines to open the Play Store link.
//     // const playStoreUrl =
//     //     "https://play.google.com/store/apps/details?id=com.sell.do";
//     // if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
//     //   await launchUrl(Uri.parse(playStoreUrl),
//     //       mode: LaunchMode.externalApplication);
//     // } else {
//     //   debugPrint("Could not launch Play Store.");
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.blueAccent,
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "An update is required!",
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _openPlayStore();
//                 },
//                 child: Text("Update Now"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
