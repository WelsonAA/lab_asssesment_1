import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? selectedGender;
  double bmiResult = 0.0;
  String healthStatus = "";
// Method to get the appropriate avatar image based on gender
  Widget getAvatar() {
    String imageUrl;

    // Set the URL based on the selected gender
    switch (selectedGender) {
      case 'Male':
        imageUrl = 'https://cdn-icons-png.flaticon.com/512/6146/6146433.png';
        break;
      case 'Female':
        imageUrl = 'data:image/png;base64,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';
        break;
      default:
        imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXU4XgzNrGtngfVHsAfBaLPvrXATF-qtoupA&s'; // Default avatar
    }

    return ClipOval(
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Display an error icon if the image fails to load
          return const Icon(
            Icons.error,
            size: 100,
            color: Colors.red,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child; // Image fully loaded
          }
          // Display a circular progress indicator while loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

  }

  // Method to calculate BMI
  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    setState(() {
      bmiResult = weight / (height * height);
      healthStatus = getHealthStatus(bmiResult);
    });
  }

  // Method to return the health status based on BMI value
  String getHealthStatus(double bmi) {
    if (bmi < 0){
      return "Invalid";
    } else if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24) {
      return "Normal";
    } else if(bmi > 24)  {
      return "Overweight";
    } else {
      return "Invalid";
    }
  }

  // Reset method
  void resetFields() {
    heightController.clear();
    weightController.clear();
    setState(() {
      selectedGender = null;
      bmiResult = 0.0;
      healthStatus = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('BMI Calculator'),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Your Height (cm)',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Your Weight (KG)',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedGender,
              hint: const Text('Select Gender'),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            // Displaying the dynamic avatar based on selected gender
            getAvatar(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                  onPressed: calculateBMI,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  onPressed: resetFields,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    selectedGender != null
                        ? 'The $selectedGender Result'
                        : 'The Result',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'BMI Calculated = ${bmiResult.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Current Status = $healthStatus',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
