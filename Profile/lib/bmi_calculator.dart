import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

enum Gender { male, female }

class _BmiCalculatorState extends State<BmiCalculator> {
  Gender? selectedGender;
  int height = 180;
  int weight = 30;
  int age = 20;
  int bmi = 0;

  final textWeightController = TextEditingController();

  Widget buildCard(double width, double height, Widget? child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1b1c2c),
      ),
      child: child,
    );
  }

  // Gender selection method
  void changeGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  // BMI Calculation
  void calculateBMI(double weight, double heightCm) {
    double heightM = heightCm / 100;
    setState(() {
      bmi = (weight / (heightM * heightM)).round();
    });
  }

  String getBmiCategory() {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 25) {
      return "Normal";
    } else if (bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  // Result Page displaying BMI and its category
  Widget resultPage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF0d101f),
        title: Text(
          "BMI RESULT",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your BMI IS $bmi",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: [
                    GaugeRange(
                      startValue: 0,
                      endValue: 18.4,
                      color: Colors.blue.shade400,
                    ),
                    GaugeRange(
                      startValue: 18.5,
                      endValue: 24.9,
                      color: Colors.green.shade400,
                    ),
                    GaugeRange(
                      startValue: 25,
                      endValue: 29.9,
                      color: Colors.yellow.shade400,
                    ),
                    GaugeRange(
                      startValue: 30,
                      endValue: 40,
                      color: Colors.pink.shade400,
                    ),
                  ],
                  pointers: [
                    NeedlePointer(
                      value: bmi.toDouble(),
                      needleColor: Colors.deepOrangeAccent,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              getBmiCategory(),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF0d101f),
          title: Text(
            "BMI CALCULATOR",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Gender selection row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildCard(
                      200.0,
                      200.0,
                      GestureDetector(
                        onTap: () => changeGender(Gender.male),
                        child: Card(
                          color: selectedGender == Gender.male
                              ? Color(0xFF1b1c2c)
                              : Color(0xFF0d101f),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.male, size: 100),
                                Text(
                                  "MALE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: buildCard(
                      200.0,
                      200.0,
                      GestureDetector(
                        onTap: () => changeGender(Gender.female),
                        child: Card(
                          color: selectedGender == Gender.female
                              ? Color(0xFF1b1c2c)
                              : Color(0xFF0d101f),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.female, size: 100),
                                Text(
                                  "FEMALE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Height slider
              buildCard(
                800.0,
                150.0,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Height",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900),
                        ),
                        Text("cm"),
                      ],
                    ),
                    Slider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      activeColor: Color(0xFFEB1555),
                      inactiveColor: Colors.grey,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.toInt();
                        });
                      },
                    )
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Weight and Age sliders in a row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildCard(
                      800.0,
                      150.0,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white54),
                          ),
                          TextField(
                            controller: textWeightController,
                            style: TextStyle(fontSize: 40, color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: textWeightController.text,
                            ),
                            onChanged: (String value) {
                              setState(() {
                                weight = int.tryParse(value) ?? weight;
                                textWeightController.text = weight.toString();
                              });
                            },
                          ),
                          Text("KG"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: buildCard(
                      800.0,
                      150.0,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white54),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                age.toString(),
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Slider(
                            value: age.toDouble(),
                            min: 12,
                            max: 90,
                            activeColor: Color(0xFFEB1555),
                            inactiveColor: Colors.grey,
                            onChanged: (double newValue) {
                              setState(() {
                                age = newValue.toInt();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 0),

              // Calculate button
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    calculateBMI(weight.toDouble(), height.toDouble());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => resultPage()),
                    );
                  },
                  color: Color(0xFFEB1555),
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
