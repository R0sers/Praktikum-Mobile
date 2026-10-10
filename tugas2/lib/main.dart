import 'package:flutter/material.dart';
import 'package:p2/KTD.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Tanda Dwarf',
      debugShowCheckedModeBanner: false,
      home: KTD(),
    );
    
  }
}