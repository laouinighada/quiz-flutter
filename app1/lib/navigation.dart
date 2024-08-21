import 'dart:async';
import 'home.dart';
import 'profile.dart';
import 'quiz.dart';
import 'program.dart';
import 'info.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<CurvedNavigationBarState> navig = GlobalKey();

class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  int index = 0;
  final screens = [
    Home(),
    profile(),
    PageQuiz(),
    ProgramPage(),
    VodPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) { 
      final now = DateTime.now();
      final timeLimit = DateTime(now.year, now.month, now.day, 12, 10);
      
      if (now.isBefore(timeLimit)) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("La page de quiz est accessible après 12h10."),
          ),
        );
        return;
      }
    }
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: navig,
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 400),
        color: Colors.black,
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.transparent,
        onTap: _onItemTapped,
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.quiz, color: Colors.white),
          Icon(Icons.schedule, color: Colors.white),
          Icon(Icons.info, color: Colors.white),
        ],
      ),
    );
  }
}
