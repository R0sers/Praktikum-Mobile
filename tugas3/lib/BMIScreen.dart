import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => BMIScreenState();
}

class BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = "Masukan Data Anda";

  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double bmi = bb / (tbM * tbM);
        _hasilBMI = bmi;

        if (bmi < 18.5) {
          _keterangan = "Kekurangan berat badan";
        } else if (bmi < 25) {
          _keterangan = "Berat badan ideal";
        } else if (bmi < 30) {
          _keterangan = "Berat badan berlebih";
        } else {
          _keterangan = "OBBESITAS";
        }
      } else {
        _hasilBMI = null;
        _keterangan = "Masukan Data Yang Valid";
      }
    });
  }

  void _reset() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = "Masukan Data Anda";
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 60, 82),
        title: Text(
          'Kalkulator BMI',
          style: TextStyle(color: Colors.white, letterSpacing: 5),
        ),
        leading: Icon(Icons.calculate, color: Colors.white),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(Icons.line_weight_outlined),
                  labelText: 'Berat Badan',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(Icons.height),
                  labelText: 'Tinggi Badan',
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _hitungBMI(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 30),
                ),
                child: Icon(Icons.calculate, size: 30),
              ),

              SizedBox(height: 20),
              Text('Hasil'),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? "--",
                      style: TextStyle(fontSize: 20, fontWeight: .bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _keterangan,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 238, 240, 241),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _reset(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 30),
                ),
                child: Icon(Icons.refresh, size: 30),
              ),
              SizedBox(height: 10),
              Text('Reset'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
