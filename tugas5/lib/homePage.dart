import 'package:flutter/material.dart';
import 'package:tugas5/DetailPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> foods = [
      {
        'nama': 'Pizza Margherita',
        'harga': 'Rp. 65.000',
        'deskripsi': 'Pizza klasik dengan saus tomat, keju mozzarella, dan daun basil segar',
        'gambar': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80'
      },
      {
        'nama': 'Cheeseburger',
        'harga': 'Rp. 45.000',
        'deskripsi': 'Burger daging sapi juicy dengan keju leleh, selada, dan tomat',
        'gambar': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80'
      },
      {
        'nama': 'Salad Sehat',
        'harga': 'Rp. 35.000',
        'deskripsi': 'Campuran sayuran segar dengan saus dressing ringan',
        'gambar': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&q=80'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.restaurant_menu),
        title: const Text('Daftar Makanan'),
        backgroundColor: const Color.fromARGB(255, 1, 20, 48),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    food['gambar']!,
                    width: 60,
                    height: 65,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 60,
                        height: 65,
                        child: Icon(Icons.fastfood),
                      );
                    },
                  ),
                ),
                title: Text(
                  food['nama']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 14, 122),
                  ),
                ),
                subtitle: Text(
                  '${food['harga']!}\n${food['deskripsi']!}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 28, 40, 155),
                  ),
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailpage(
                        Nama: food['nama']!,
                        Harga: food['harga']!,
                        Deskripsi: food['deskripsi']!,
                        Gambar: food['gambar']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}