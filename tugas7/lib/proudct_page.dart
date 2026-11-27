import 'package:flutter/material.dart';
import 'package:tugas7/cart_model.dart';
import 'package:tugas7/cart_page.dart';
import 'package:provider/provider.dart';

class ProudctPage extends StatelessWidget {
  final products = [
    Products('Namaku Alam','Leila S. Chudori'),
    Products('Laut Bercerita','Leila S. Chudori'),
    Products('Dunia Shopie','Justin Gaarder'),
    Products('Mutiara Agista Utami','Robi Septiandi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku'),
        backgroundColor: const Color.fromARGB(255, 61, 87, 99),
        foregroundColor: const Color.fromARGB(255, 255, 254, 254),
        
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return Badge(
                    label: Text('${cart.totalItems}'),
                    isLabelVisible: cart.totalItems >0,
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                                builder: (context) => CartPage(),
                              )
                          );
                        },
                         icon: Icon(Icons.shopping_cart),
                         
                    ),
                  );
                },
              ),
            )
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final book = products[index];
          return Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.book,),
              ),
              title: Text(book.nama),
              subtitle: Text(book.penulis),
              trailing: IconButton(
                  onPressed: () {
                    Provider.of<CartModel>(context, listen:false).add(book);
                  },
                  icon: Icon(Icons.add_shopping_cart),
              ),
            ),
          );
        },
      ),

    );
  }
}