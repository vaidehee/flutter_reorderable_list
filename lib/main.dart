import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ReOrderable List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ReorderableListScreen(),
    );
  }
}
