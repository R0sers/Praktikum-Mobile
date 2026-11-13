import 'package:flutter/material.dart';
import 'package:tugas6/homePage.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, String>> bookData = [
  {
    'nama': 'Laut Bercerita',
    'gambar': 'https://tse1.mm.bing.net/th/id/OIP._Rc46S5f8zMO5fj1IprrjQHaE8?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    'isbn': '9786024246945'
  },
  {
    'nama': 'Islam ala Prabowo',
    'gambar': 'https://th.bing.com/th/id/OIP.zGoCEiauvljNrpmGDc9kEwHaE8?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
    'isbn': 'Prawowo0940384'
  },
  {
    'nama': 'Sesederhana Rasaku Serumit Kepastianmu',
    'gambar': 'https://tse2.mm.bing.net/th/id/OIP.JZvUqJ0ZVXpisWPdGxTf5gHaE7?r=0&w=632&h=420&rs=1&pid=ImgDetMain&o=7&rm=3',
    'isbn': '9786237100447'
  },
  {
    'nama': 'Bumi Manusia',
    'gambar': 'https://tse3.mm.bing.net/th/id/OIP.cYhzBHfRnAsJbtDh56IN4AHaE7?r=0&w=1600&h=1066&rs=1&pid=ImgDetMain&o=7&rm=3',
    'isbn': '9789799731234'
  },
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'roXse Book',
      home: HomePage(bookData: bookData),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        )
      ),
    );
  }
}