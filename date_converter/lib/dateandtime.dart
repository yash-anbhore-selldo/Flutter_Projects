import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class TimeConverterScreen extends StatefulWidget {
  @override
  _TimeConverterScreenState createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  String selectedTimeZone = 'America/New_York';
  String convertedTime = '';
  DateTime currentTime = DateTime.now();

  final List<String> timeZones = [
    'America/New_York', // USA (EST)
    'America/Los_Angeles', // USA (PST)
    'Asia/Dubai', // Dubai
    'Europe/London', // UK
    'Australia/Sydney', // Australia
    'Asia/Kolkata', // IST
  ];

  /// Convert `currentTime` to the selected time zone
  void convertTime(DateTime time) {
    final targetZone = tz.getLocation(selectedTimeZone);
    final converted = tz.TZDateTime.from(time, targetZone);

    setState(() {
      convertedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(converted);
      currentTime = time; // Keep track of current date
    });
  }

  /// Move to the next month while ensuring valid dates
  void nextMonth() {
    DateTime nextMonthDate = DateTime(
      currentTime.year,
      currentTime.month + 1,
      currentTime.day < 28 ? currentTime.day : 28, // Prevents invalid dates
    );
    convertTime(nextMonthDate);
  }

  /// Move to the previous month while ensuring valid dates
  void prevMonth() {
    DateTime prevMonthDate = DateTime(
      currentTime.year,
      currentTime.month - 1,
      currentTime.day < 28 ? currentTime.day : 28, // Prevents invalid dates
    );
    convertTime(prevMonthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IST to Time Zone Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a Time Zone:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedTimeZone,
              items: timeZones.map((String tz) {
                return DropdownMenuItem<String>(
                  value: tz,
                  child: Text(tz),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTimeZone = value!;
                });
                convertTime(currentTime);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => convertTime(DateTime.now()),
              child: const Text('Convert Time'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: prevMonth,
                  child: const Text('Previous Month'),
                ),
                ElevatedButton(
                  onPressed: nextMonth,
                  child: const Text('Next Month'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              convertedTime.isNotEmpty
                  ? 'Converted Time: $convertedTime'
                  : 'No conversion yet',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
