import 'package:flutter/material.dart';
import 'package:providerr/homepage.dart';
import 'package:providerr/playlistpage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedindex = 0;

  void _currentitem(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  final List<Widget> pages = [
    const HomePage(),
    const PlayList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            label: "Playlist",
          ),
        ],
        currentIndex: selectedindex,
        onTap: _currentitem,
      ),
    );
  }
}
