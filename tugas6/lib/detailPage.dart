import 'package:flutter/material.dart';

class Detailpage extends StatelessWidget {
  final String Nama, Gambar, Isbn;

  const Detailpage({
    super.key,
    required this.Nama,
    required this.Gambar,
    required this.Isbn,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Hitam gelap (Latar belakang utama)
      appBar: AppBar(
        title: Text(
          Nama,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF0F172A), // Biru gelap / Navy modern
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFF1E293B), // Card warna abu-kebiruan gelap
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar dengan sudut melengkung
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    Gambar,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Nama Produk
                Text(
                  Nama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                
                const Divider(
                  height: 30,
                  color: Color(0xFF334155), // Garis pembatas yang lebih lembut
                  thickness: 1,
                ),
                
                // Label Deskripsi
                const Text(
                  "Deskripsi",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Isi Deskripsi

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}