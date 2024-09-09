import 'package:flutter/material.dart';
import 'seller_page.dart'; // Import SellerPage
import 'buyer_page.dart'; // Import BuyerPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutUsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reachOutKey = GlobalKey();

  int _selectedIndex = 0;
  bool _isSellerSelected = false;
  bool _isBuyerSelected = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Scroll to the respective section
    switch (index) {
      case 0:
        _scrollToSection(_homeKey);
        break;
      case 1:
        _scrollToSection(_aboutUsKey);
        break;
      case 2:
        _scrollToSection(_servicesKey);
        break;
      case 3:
        _scrollToSection(_reachOutKey);
        break;
    }
  }

  void _scrollToSection(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null);
    final offset = _scrollController.offset + position.dy;

    _scrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToPage() {
    if (_isSellerSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SellerPage()),
      );
    } else if (_isBuyerSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BuyerPage()),
      );
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
                _topNavBarItem('Home', 0),
                _topNavBarItem('About Us', 1),
                _topNavBarItem('Services', 2),
                _topNavBarItem('Reach Out', 3),
              ],
            ),
          ),
          // Image and Text Content
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                _buildHomeSection(),
                _buildAboutUsSection(),
                _buildServicesSection(),
                _buildReachOutSection(),
              ],
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

  Widget _buildHomeSection() {
    return Container(
      key: _homeKey,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center content horizontally
        children: [
          Text(
            'Fresh Farm Here!!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Center the text
          ),
          SizedBox(height: 20),
          Text(
            'Choose Your Role?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center, // Center the text
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSellerSelected = true;
                    _isBuyerSelected = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isSellerSelected ? Colors.green : Colors.grey,
                ),
                child: Text('Seller'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isBuyerSelected = true;
                    _isSellerSelected = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isBuyerSelected ? Colors.orange : Colors.grey,
                ),
                child: Text('Buyer'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_isSellerSelected || _isBuyerSelected) {
                  _navigateToPage(); // Navigate to SellerPage or BuyerPage
                } else {
                  // Optionally show a message if no role is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a role before continuing.'),
                    ),
                  );
                }
              },
              child: Text(
                'Get Started!',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset('assets/logo.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection() {
    return Container(
      key: _aboutUsKey,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Image.asset('assets/aboutus.jpg', fit: BoxFit.cover),
          SizedBox(height: 20),
          Text(
            'Welcome to FarmNest! We\'re your go-to source for farm-fresh products delivered right to your doorstep. By choosing FarmNest, you support local farmers while enjoying the freshest produce, dairy, meats, and more—all with the convenience of home delivery. Experience the best of farm-to-table living with just a few clicks. Thank you for being part of our community!',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Container(
      key: _servicesKey,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Image.asset('assets/vege.jpg', fit: BoxFit.cover),
          SizedBox(height: 20),
          Text(
            'FarmNest makes it easy to get farm-fresh vegetables and other products delivered straight to your home. We offer a wide range of high-quality, locally-sourced produce, dairy, meats, and artisanal goods. Supporting local farmers, we ensure you receive the freshest ingredients with the convenience of home delivery. Experience farm-to-table living with FarmNest today!',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildReachOutSection() {
    return Container(
      key: _reachOutKey,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reach Out',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email/Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle submit logic
            },
            child: Text('Submit'),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
