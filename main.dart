import 'package:flutter/material.dart';
import 'package:manga_app/pages/chapter_page.dart';
import 'package:manga_app/pages/details_page.dart';
import 'package:manga_app/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Series',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'details' : (BuildContext context) => DetailsPage(),
        'chapters' : (BuildContext context) => ChapterPage(),

      },
    );
  }
}