import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white10,
          // appBar: AppBar(
          //   // centerTitle: true,
          //   // backgroundColor: Colors.teal,
          //   title: Text(
          //     "Profile",
          //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          //   ),
          // ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 30,
                // ),
                ListTile(
                  // this helps to remove the padding of parent Padding widget
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.light_mode,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleAvatar(
                  // backgroundColor: Colors.black,
                  radius: 60,
                  backgroundImage: AssetImage('images/profile_pic.jpg'),
                ),

                // SizedBox for spacing
                SizedBox(height: 10),
                Text(
                  "Yash Anbhore",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'ShortBaby'),
                ),
                Text(
                  "yash_anbohre@sell.do",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                      fontSize: 15,
                      fontFamily: 'ShortBaby'),
                ),
                SizedBox(height: 20),

                // we could have used Column but it causes
                // the overflow issue
                // expanded handles multiple card if it exceeds the screen
                // it allows scrollable
                Expanded(
                    child: ListView(
                  children: [
                    buildCard(Icons.person, "Profile"),
                    SizedBox(
                      height: 5,
                    ),
                    buildCard(Icons.share, "Invite"),
                    SizedBox(
                      height: 5,
                    ),
                    buildCard(Icons.settings, "Settings"),
                    SizedBox(
                      height: 5,
                    ),
                    buildCard(Icons.help, "Help and Support"),
                    SizedBox(
                      height: 5,
                    ),
                    buildCard(Icons.logout, "Logout"),
                  ],
                ))
              ],
            ),
          )
          // appBar: ,
          ),
    );
  }

  Widget buildCard(IconData icon, String text) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      color: Colors.white10,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'ShortBaby', fontSize: 18, color: Colors.white),
        ),
        trailing: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white54,
        ),
      ),
    );
  }
}
