import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final note = AudioPlayer();

  int? isplaying;
  void playNote(int i) {
    if (isplaying == i) {
      setState(() {
        note.stop();
        isplaying = null;
      });
    } else {
      setState(() {
        note.play(AssetSource('note$i.wav'));
        isplaying = i;
      });
    }
  }

  List<MaterialColor> buttoncolor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    //if you return scaffold it will give you the back arrow
    //if material app it wont give you the arrow to go back
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Note",
          style: TextStyle(fontSize: 23),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              children: List.generate(7, (index) {
            return Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: MaterialButton(
                onPressed: () {
                  playNote(index + 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: buttoncolor[index],
                  ),
                  child: Center(
                    child: isplaying == index + 1
                        ? Icon(
                            Icons.pause_circle,
                            color: Colors.white70,
                            size: 50,
                          )
                        : Icon(
                            Icons.play_circle,
                            color: Colors.white70,
                            size: 50,
                          ),
                  ),
                ),
              ),
            ));
          }))),
    );
  }
}
