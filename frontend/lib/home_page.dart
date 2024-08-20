import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected index
    switch (index) {
      case 0:
        // Handle navigation to About Us
        break;
      case 1:
        // Handle navigation to Services
        break;
      case 2:
        // Handle navigation to Reach Out
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Navigation Bar
          Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _topNavBarItem('About Us', 0),
                _topNavBarItem('Services', 1),
                _topNavBarItem('Reach Out', 2),
              ],
            ),
          ),
          // Image and Text Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                    ),
                    child: Image.asset(
                      'assets/aboutus.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Text Content
                  Text(
                    'Welcome to FarmNest! We\'re your go-to source for farm-fresh products delivered right to your doorstep. By choosing FarmNest, you support local farmers while enjoying the freshest produce, dairy, meats, and more—all with the convenience of home delivery. Experience the best of farm-to-table living with just a few clicks. Thank you for being part of our community!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topNavBarItem(String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.white54,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
