import 'package:flutter/material.dart';
import 'package:uts_simulasi/menufood.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Warung Opang",
      home: Mainfoodmenu(),
    );
  }
}
