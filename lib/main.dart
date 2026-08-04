import 'package:flutter/material.dart';

void main() => runApp(const ZaminYarApp());

class ZaminYarApp extends StatelessWidget {
  const ZaminYarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'زمین یار',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double sideNorth = 20.0;
  double sideSouth = 20.0;
  double sideEast = 30.0;
  double sideWest = 30.0;

  double get calculatedArea {
    double avgWidth = (sideNorth + sideSouth) / 2;
    double avgLength = (sideEast + sideWest) / 2;
    return avgWidth * avgLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('زمین یار | محاسبه ابعاد و مساحت'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                border: Border.all(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.landscape, size: 48, color: Colors.teal),
                  const SizedBox(height: 8),
                  Text(
                    'مساحت تقریبی: ${calculatedArea.toStringAsFixed(1)} متر مربع',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('شمال: $sideNorth م | جنوب: $sideSouth م | شرق: $sideEast م | غرب: $sideWest م'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSlider('ضلع شمالی (متر)', sideNorth, (val) => setState(() => sideNorth = val)),
            _buildSlider('ضلع جنوبی (متر)', sideSouth, (val) => setState(() => sideSouth = val)),
            _buildSlider('ضلع شرقی (متر)', sideEast, (val) => setState(() => sideEast = val)),
            _buildSlider('ضلع غربی (متر)', sideWest, (val) => setState(() => sideWest = val)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('اطلاعات زمین ثبت شد.')),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('ذخیره اطلاعات زمین'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toInt()} متر'),
        Slider(
          value: value,
          min: 1,
          max: 200,
          divisions: 199,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
