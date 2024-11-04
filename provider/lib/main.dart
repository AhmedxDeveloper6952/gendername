import 'package:flutter/material.dart';

import 'package:providerr/bottomnavbar.dart';

//import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(), // Set BottomNavBar as the home
    );
  }
}
