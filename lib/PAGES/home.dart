import 'package:flutter/material.dart';
import 'package:josiah_arising/PAGES/devotional.dart';
import 'package:josiah_arising/PAGES/hymns.dart';
import 'package:josiah_arising/PAGES/notes.dart';
import '../WIDGETS/colors.dart';

// Model classes for our data
class Devotional {
  final String title;
  final DateTime date;
  final String imageUrl;
  final String content;

  Devotional({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
  });
}

class Hymn {
  final String title;
  final String author;
  final String imageUrl;

  Hymn({required this.title, required this.author, required this.imageUrl});
}

class Note {
  final String title;
  final String date;
  final String preview;

  Note({required this.title, required this.date, required this.preview});
}

// Devotionals Page


// Enhanced Hymns Page


// Enhanced Notes Page


// HomePageNavBar remains largely the same but with enhanced styling
class HomePageNavBar extends StatefulWidget {
  const HomePageNavBar({super.key});
  
  @override
  State<HomePageNavBar> createState() => _HomePageNavBarState();
}

class _HomePageNavBarState extends State<HomePageNavBar> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    DevotionalsPage(),
    HymnsPage(),
    NotesPage(),
  ];

  final List<String> _titles = [
    'DEVOTIONALS',
    'HYMNS',
    'NOTES',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            color: CustomColors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: CustomColors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Hymns',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
        elevation: 4,
      ),
    );
  }
}