import 'package:flutter/material.dart';
import 'package:tugas8/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, temaProvider, child) {
        return MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: temaProvider.themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Setting Tema',
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Isi field dengan nama yang sudah tersimpan (jika data sudah selesai dimuat)
    final provider = context.read<ThemeProvider>();
    _nameController.text = provider.userName;
    // Provider memuat data secara async, jadi sinkronkan lagi saat berubah
    provider.addListener(_syncName);
  }

  void _syncName() {
    final saved = context.read<ThemeProvider>().userName;
    if (_nameController.text.isEmpty && saved.isNotEmpty) {
      _nameController.text = saved;
    }
  }

  @override
  void dispose() {
    context.read<ThemeProvider>().removeListener(_syncName);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Tema'),
        centerTitle: true,
        leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 200,
                color: isDark
                    ? Colors.amber
                    : const Color.fromARGB(255, 248, 146, 29),
              ),
              Text(
                isDark ? 'Dark Mode' : 'Light Mode',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Sapaan dengan nama yang tersimpan
              Text(
                themeProvider.userName.isEmpty
                    ? 'Halo, silakan masukkan nama kamu'
                    : 'Halo, ${themeProvider.userName}!',
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Input nama
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengguna',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Nama'),
                  onPressed: () {
                    themeProvider.saveUserName(_nameController.text);
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama berhasil disimpan')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: SwitchListTile(
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  title: Text(isDark ? 'Aktif' : 'Tidak Aktif'),
                  value: isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
