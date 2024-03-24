import 'package:flutter/material.dart';

import 'pagess/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webby Fondue',
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity.standard,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 143, 173, 198), // กำหนดสีพื้นหลังให้ AppBar ที่นี่
        ),scaffoldBackgroundColor: Color.fromARGB(255, 208, 227, 120),
      ),
      home: const HomePage(),
    );
  }
}

// เพิ่มข้อความ "รายงานเว็ปเลวๆ"
final String evilReportText = "รายงานเว็บเลวๆ";
