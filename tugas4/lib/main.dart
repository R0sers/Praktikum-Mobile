import 'package:flutter/material.dart';

import 'article_model.dart';
import 'api_service.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Roboto',
      ),
      home: const NewsAppScreen(),
    );
  }
}

class NewsAppScreen extends StatefulWidget {
  const NewsAppScreen({super.key});

  @override
  State<NewsAppScreen> createState() => _NewsAppScreenState();
}

class _NewsAppScreenState extends State<NewsAppScreen> {
  late Future<List<Article>> _articlesFuture;

  // Controller untuk mengatur posisi scroll
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService().fetchArticles();

    // Pantau posisi scroll untuk menampilkan/menyembunyikan tombol
    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 300;
      if (shouldShow != _showBackToTop) {
        setState(() {
          _showBackToTop = shouldShow;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi pull-to-refresh
  Future<void> _refreshArticles() async {
    final future = ApiService().fetchArticles();
    setState(() {
      _articlesFuture = future;
    });
    try {
      await future;
    } catch (_) {
      // Error sudah ditangani oleh FutureBuilder
    }
  }

  // Fungsi kembali ke atas
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Portal Berita',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshArticles,
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (snapshot.hasError) {
            // ListView agar pull-to-refresh tetap bisa dipakai saat error
            return RefreshIndicator(
              color: Colors.indigo,
              onRefresh: _refreshArticles,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Terjadi Kesalahan:\n${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final articles = snapshot.data!;

            return RefreshIndicator(
              color: Colors.indigo,
              onRefresh: _refreshArticles,
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () {
                          // Tambahkan aksi ketika card ditekan (misal: Buka Detail)
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty)
                              Stack(
                                children: [
                                  Image.network(
                                    article.urlToImage!,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Berita Terbaru',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3142),
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article.description ??
                                        'Tidak Ada Deskripsi Tersedia.',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Baca Selengkapnya',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo[700],
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: Colors.indigo[700],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return RefreshIndicator(
              color: Colors.indigo,
              onRefresh: _refreshArticles,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text(
                        'Berita Tidak Ditemukan',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),

      // Tombol kembali ke atas, muncul hanya setelah scroll cukup jauh
      floatingActionButton: AnimatedScale(
        scale: _showBackToTop ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: Colors.indigo,
          tooltip: 'Kembali ke atas',
          child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
        ),
      ),
    );
  }
}
