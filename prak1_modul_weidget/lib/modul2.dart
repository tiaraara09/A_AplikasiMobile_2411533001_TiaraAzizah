import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. WIDGET UTAMA (Root Aplikasi)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

// 2. HALAMAN UTAMA (Scaffold)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 2: Layouting'),
        backgroundColor: Colors.blue,
      ),
      // Menggunakan SingleChildScrollView agar layar bisa di-scroll
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(), // Dari Modul 1
              SizedBox(height: 20),
              BalanceCardWidget(), // Dari Modul 1
              SizedBox(height: 20),
              ActionButtonsWidget(), // Widget Row - Modul 2
              SizedBox(height: 20),
              RecentTransactionsWidget(), // Widget Column - Modul 2
            ],
          ),
        ),
      ),
    );
  }
}

// 3. STATELESS WIDGET (Sapaan - Dari Modul 1)
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 30, color: Colors.white),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, Zz',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Selamat datang kembali!',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

// 4. STATEFUL WIDGET (Kartu Saldo - Dari Modul 1)
class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<BalanceCardWidget> {
  bool _isBalanceVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Saldo Utama',
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
                IconButton(
                  icon: Icon(
                      _isBalanceVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBalanceVisible ? 'Rp 5.000.000' : 'Rp *********',
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. WIDGET TOMBOL AKSI (ROW)
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Jarak dibagi rata
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.blue),
      ],
    );
  }

  // Fungsi pembantu agar kode tombol tidak berulang
  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// 6. MODEL DATA TRANSAKSI
// Dipakai supaya warna trailing text bisa ditentukan otomatis dari nominal
// (Tugas 1: pengeluaran -> merah, pemasukan -> hijau)
class Transaksi {
  final String judul;
  final String tanggal;
  final int nominal; // positif = pemasukan, negatif = pengeluaran
  final IconData icon;
  final Color iconBgColor;

  const Transaksi({
    required this.judul,
    required this.tanggal,
    required this.nominal,
    required this.icon,
    required this.iconBgColor,
  });

  bool get isPemasukan => nominal >= 0;

  String get nominalText {
    final absNominal = nominal.abs();
    final formatted = absNominal.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
    return '${isPemasukan ? '+' : '-'} Rp $formatted';
  }

  Color get nominalColor => isPemasukan ? Colors.green : Colors.red;
}

// 7. WIDGET DAFTAR TRANSAKSI (COLUMN & LISTTILE)
class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key});

  // Daftar transaksi: 3 data asli dari modul + 2 data baru (Tugas 2)
  static final List<Transaksi> _transaksiList = [
    const Transaksi(
      judul: 'Makan Siang',
      tanggal: 'Hari ini',
      nominal: -50000,
      icon: Icons.fastfood,
      iconBgColor: Colors.redAccent,
    ),
    const Transaksi(
      judul: 'Gaji Bulanan',
      tanggal: 'Kemarin',
      nominal: 5000000,
      icon: Icons.attach_money,
      iconBgColor: Colors.green,
    ),
    const Transaksi(
      judul: 'Belanja Bulanan',
      tanggal: 'Kemarin',
      nominal: -200000,
      icon: Icons.shopping_cart,
      iconBgColor: Colors.orange,
    ),
    const Transaksi(
      judul: 'Bonus',
      tanggal: '14 Sep 2026',
      nominal: 2000000,
      icon: Icons.card_giftcard,
      iconBgColor: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaksi Terakhir',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: _buildTransactionTiles(),
          ),
        ),
      ],
    );
  }

  // Membangun daftar ListTile + Divider dari _transaksiList
  List<Widget> _buildTransactionTiles() {
    final List<Widget> tiles = [];
    for (var i = 0; i < _transaksiList.length; i++) {
      final t = _transaksiList[i];
      tiles.add(
        ListTile(
          leading: CircleAvatar(
            backgroundColor: t.iconBgColor,
            child: Icon(t.icon, color: Colors.white),
          ),
          title: Text(t.judul),
          subtitle: Text(t.tanggal),
          // Tugas 1: warna otomatis merah (pengeluaran) / hijau (pemasukan)
          trailing: Text(
            t.nominalText,
            style: TextStyle(color: t.nominalColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
      if (i != _transaksiList.length - 1) {
        tiles.add(const Divider(height: 1));
      }
    }
    return tiles;
  }
}