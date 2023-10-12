import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/home/tabbar_view.dart';
import 'package:twitter_clone/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone UI Example',
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
          textTheme: Theme.of(context).textTheme.copyWith(
                  headlineLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          tabBarTheme: const TabBarTheme(
              labelColor: CupertinoColors.activeBlue, unselectedLabelColor: CupertinoColors.inactiveGray)),
      home: TwitterTabbarView(),
    );
  }
}
