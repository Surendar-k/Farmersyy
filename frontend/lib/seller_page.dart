import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController? _tabController;
  List<Vegetable> _vegetables = [];

  // Pages for each tab
  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')),
    Center(child: Text('Orders Page Content')),
    Center(child: Text('My Farm Page Content')),
    Center(child: Text('Trade Page Content')),
    Center(child: Text('Reach Out Page Content')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Future<void> _fetchVegetables() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/vegetables'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _vegetables = data.map((item) => Vegetable.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load vegetables');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Assuming "Vegetables" is related to Home tab
        _fetchVegetables();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Page'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              if (index == 0) {
                // Assuming "Vegetables" corresponds to Home tab
                _fetchVegetables();
              }
            });
          },
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Orders'),
            Tab(text: 'My Farm'),
            Tab(text: 'Trade'),
            Tab(text: 'Reach Out'),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex =
                                0; // Assuming "Vegetables" corresponds to Home tab
                            _fetchVegetables();
                          });
                        },
                        child: Text('Vegetables'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1; // Change this index if needed
                          });
                        },
                        child: Text('Fruits'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2; // Change this index if needed
                          });
                        },
                        child: Text('Other Products'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _vegetables.length,
                    itemBuilder: (context, index) {
                      final vegetable = _vegetables[index];
                      return ListTile(
                        leading: Image.network(vegetable.imageUrl,
                            width: 50, height: 50),
                        title: Text(vegetable.name),
                      );
                    },
                  ),
                ),
              ],
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'My Farm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Reach Out',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

class Vegetable {
  final String name;
  final String imageUrl;

  Vegetable({required this.name, required this.imageUrl});

  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
