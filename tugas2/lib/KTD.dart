import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KTD extends StatelessWidget {
  const KTD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 92, 49),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/eisen2.jpg'),
                radius: 75.0,
              ),
              Text(
                'EISEN',
                style: GoogleFonts.geologica(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: .bold,
                ),
              ),
              Text(
                'From Hero Party',
                style: GoogleFonts.aboreto(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: .normal,
                  letterSpacing: 2,
                ),
              ),

              SizedBox(
                height: 20,
                width: 310,
                child: Divider(color: const Color.fromARGB(255, 255, 255, 255)),
              ),

              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: Colors.red,
                  leading: Icon(Icons.stream),
                  title: Text(
                    'Strength : 90000++',
                    style: GoogleFonts.geologica(),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: const Color.fromARGB(255, 24, 196, 70),
                  leading: Icon(Icons.heart_broken),
                  title: Text(
                    'Live : ??????????',
                    style: GoogleFonts.geologica(),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: const Color.fromARGB(255, 24, 70, 196),
                  leading: Icon(Icons.snowshoeing_sharp),
                  title: Text('Agility : 5000', style: GoogleFonts.geologica()),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: const Color.fromARGB(255, 24, 70, 196),
                  leading: Icon(Icons.snowshoeing_sharp),
                  title: Text('Agility : 5000', style: GoogleFonts.geologica()),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: const Color.fromARGB(255, 2, 57, 102),
                  leading: Icon(Icons.house),
                  title: Text(
                    'Address : Bredt Region, Dwarf Kingdom',
                    style: GoogleFonts.geologica(),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: ListTile(
                  iconColor: const Color.fromARGB(255, 24, 70, 196),
                  leading: Icon(Icons.share),
                  title: Text(
                    'Connection : Party From Hero',
                    style: GoogleFonts.geologica(),
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
