import 'package:flutter/material.dart';
import 'add_transaction_screen.dart.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker - Modul 3',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Tema warna modul 3
      ),
      home: const AddTransactionScreen(), // Langsung membuka halaman form
    );
  }
}