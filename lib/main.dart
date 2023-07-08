import 'package:flutter/material.dart';
import 'package:to_do_list/database/database.dart';

import 'pages/home_page.dart';

void main() async {
  await db.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
