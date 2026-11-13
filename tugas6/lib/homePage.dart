import 'package:flutter/material.dart';
import 'package:tugas6/detailPage.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> bookData;

  const HomePage({super.key, required this.bookData});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: AppBar(title: Text('roXse Book'),
            bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.view_agenda_rounded),
                    text: 'List View',
                  ),
                  Tab(
                    icon: Icon(Icons.grid_view),
                    text: 'Grid View',
                  )
                ]
              ),
          ),
          body: TabBarView(
              children:[
                buildListView(),
                buildGridView()
                ]
              ),
              
        ),
      );
  }
  Widget buildListView(){
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: bookData.length,
        itemBuilder: ((context, index) {
          final item = bookData[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10)
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                child: Image.network(
                  item['gambar']!,
                  fit: .cover,
                  width: 80,
                  height: 80,
                ),
              ),
              title: Text(item['nama']!),
              subtitle: Text(item['isbn']!),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => Detailpage(
                      Nama: item['nama']!, 
                      Gambar: item['gambar']!,
                      Isbn : item['isbn']!
                    ),
                  ),
                );
              },
            ),
            
          );
        })
      );
  }
  Widget buildGridView(){
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: bookData.length,
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ngatur kolom
          crossAxisSpacing: 10, // jark horizonta
          mainAxisSpacing: 10, // jarak vertikal
          childAspectRatio: 1
        ),
        
        
      itemBuilder: (context, index) {
        final item = bookData[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: .circular(10)
          ),
          clipBehavior: .antiAlias, 
          
          child: Stack(
            fit: .expand,
            
            children: [
              Image.network(item['gambar']!,
              fit: .cover,
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  item['nama']!,
                  style: TextStyle(color: Colors.white),
                  
                ),
              
                
              ),
              ListTile(
                // trailing:,
                onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => Detailpage(
                      Nama: item['nama']!, 
                      Gambar: item['gambar']!,
                      Isbn : item['isbn']!
                    ),
                  ),
                );
              },
              )
            ],
          ),
        );
      },
      
    );
  }
}