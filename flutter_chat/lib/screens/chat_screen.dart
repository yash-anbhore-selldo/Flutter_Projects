import 'dart:collection';

import 'package:flutter/material.dart';
// import 'package:flash_chat/constants.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/screens/profile_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _controller = TextEditingController();

  late SharedPreferences sharedPrefs;

  final _auth = FirebaseAuth.instance;
  String messageText = '';

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    reDirectTo(context, () => WelcomeScreen("data"), state: this);
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print("Text : ${message.data()}");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    // getMessages();
    messageStream();
  }

  void empty() {
    messageText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
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
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () async {
                sharedPrefs = await SharedPreferences.getInstance();
                sharedPrefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomeScreen("ss")));
                //Implement logout functionality
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: _controller,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = '';
                          sharedPrefs.setString('text', messageText);
                          sharedPrefs.setString('email', loggedInUser.email);
                        });
                        //Implement send functionality.
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: Colors.white,
            );
          }
          final messages = snapshot.data!.docs;
          List<MessageBubble> messageBubbles = [];

          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentUser = loggedInUser.email;

            if (currentUser == messageSender) {}
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: messageBubbles,
            ),
          );

          return SizedBox();
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 5,
            color: isMe ? Colors.blueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "$text ",
                style: TextStyle(
                    fontSize: 16, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
