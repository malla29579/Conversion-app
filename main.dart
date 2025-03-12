import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConversionScreen(),
    );
  }
}

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  // Defining variables to keep track of the user's choices.
  String selectedMeasure = 'Length';
  String fromUnit = 'Miles';
  String toUnit = 'Kilometers';
  double inputValue = 0;
  String resultMessage = '';

  // A map of unit options categorized by measurement type.
  final Map<String, List<String>> unitOptions = {
    'Length': ['Miles', 'Kilometers'],
    'Weight': ['Pounds', 'Kilograms'],
    'Temperature': ['Celsius', 'Fahrenheit'],
  };

  // Conversion logic based on selected measurement type.
  void convert() {
    setState(() {
      if (selectedMeasure == 'Length') {
        if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
          double resultValue = inputValue * 1.60934;
          resultMessage = '$inputValue $fromUnit is ${resultValue.toStringAsFixed(3)} $toUnit';
        } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
          double resultValue = inputValue / 1.60934;
          resultMessage = '$inputValue $fromUnit is ${resultValue.toStringAsFixed(3)} $toUnit';
        }
      } else if (selectedMeasure == 'Weight') {
        if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
          double resultValue = inputValue * 0.453592;
          resultMessage = '$inputValue $fromUnit is ${resultValue.toStringAsFixed(3)} $toUnit';
        } else if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
          double resultValue = inputValue / 0.453592;
          resultMessage = '$inputValue $fromUnit is ${resultValue.toStringAsFixed(3)} $toUnit';
        }
      } else if (selectedMeasure == 'Temperature') {
        if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
          double resultValue = (inputValue * 9 / 5) + 32;
          resultMessage = '$inputValue° $fromUnit is ${resultValue.toStringAsFixed(3)}° $toUnit';
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
          double resultValue = (inputValue - 32) * 5 / 9;
          resultMessage = '$inputValue° $fromUnit is ${resultValue.toStringAsFixed(3)}° $toUnit';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar title and background color
      appBar: AppBar(
        title: Text('AHands On Assignment_Converting app'),
        backgroundColor: Colors.blueGrey,
      ),
      // I changed the background color to make the app more visually appealing
      backgroundColor: Colors.teal.shade100,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown menu to select measurement category (Length, Weight, Temperature)
            Row(
              children: [
                Text(
                  "Select the type of unit:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                DropdownButton<String>(
                  value: selectedMeasure,
                  items: unitOptions.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key, style: TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMeasure = value!;
                      fromUnit = unitOptions[value]![0];
                      toUnit = unitOptions[value]![1];
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Dropdown for the "From" unit based on selected measurement type
            Row(
              children: [
                Text(
                  "Select Unit:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                DropdownButton<String>(
                  value: fromUnit,
                  items: unitOptions[selectedMeasure]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit, style: TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Dropdown for the "To" unit based on selected measurement type
            Row(
              children: [
                Text(
                  "Select Unit to convert:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                DropdownButton<String>(
                  value: toUnit,
                  items: unitOptions[selectedMeasure]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit, style: TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Input field for the user to enter the value they want to convert
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Type the number to convert',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              onChanged: (value) {
                setState(() {
                  inputValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            // Button to trigger the conversion
            ElevatedButton(
              onPressed: convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            // Display the conversion result
            Text(
              resultMessage,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
