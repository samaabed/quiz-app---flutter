
import 'package:flutter/material.dart';
import 'package:test_test/home_page.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       title: 'test app',
       theme: ThemeData(),
       home: const HomePage()
    );
  }

}

