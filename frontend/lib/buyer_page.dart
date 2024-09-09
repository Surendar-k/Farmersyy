import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BuyerPage(),
    );
  }
}

class BuyerPage extends StatefulWidget {
  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  String? selectedCategory;
  String? selectedProduct;

  // List to hold orders
  List<Map<String, dynamic>> orders = [];

  // Main categories and their sub-items
  final Map<String, List<Map<String, dynamic>>> categories = {
    'Nuts': [
      {'name': 'Almonds', 'price': 5.99},
      {'name': 'Cashews', 'price': 4.99},
      {'name': 'Walnuts', 'price': 6.99},
     
    ],
    'Vegetables': [
      {'name': 'Carrots', 'price': 2.99},
      {'name': 'Broccoli', 'price': 3.49},
      {'name': 'Spinach', 'price': 1.99},
    ],
    'Fruits': [
      {'name': 'Apples', 'price': 2.99},
      {'name': 'Bananas', 'price': 1.49},
      {'name': 'Grapes', 'price': 3.99},
    ],
    'Flowers': [
      {'name': 'Roses', 'price': 10.99},
      {'name': 'Lilies', 'price': 9.49},
      {'name': 'Tulips', 'price': 8.99},
    ],
  };

  // Farmer information for each product
  final Map<String, List<Map<String, dynamic>>> farmers = {
    'Almonds': [
      {
        'name': 'Farmer Amy',
        'rating': 4.5,
        'phone': '123-456-7890',
        'location': 'Nutty Acres',
        'items': ['Almonds', 'Cashews'],
      },
      {
        'name': 'Farmer Aaron',
        'rating': 4.3,
        'phone': '987-654-3210',
        'location': 'Healthy Harvest',
        'items': ['Almonds', 'Walnuts'],
      },
    ],
    'Cashews': [
      {
        'name': 'Farmer Carl',
        'rating': 4.7,
        'phone': '111-222-3333',
        'location': 'Tropical Farms',
        'items': ['Cashews'],
      },
    ],
    'Walnuts': [
      {
        'name': 'Farmer Wendy',
        'rating': 4.6,
        'phone': '555-444-7777',
        'location': 'Walnut Grove',
        'items': ['Walnuts'],
      },
    ],
    'Carrots': [
      {
        'name': 'Farmer John',
        'rating': 4.5,
        'phone': '123-456-7890',
        'location': 'Farmville',
        'items': ['Carrots', 'Broccoli'],
      },
      {
        'name': 'Farmer Jane',
        'rating': 4.0,
        'phone': '987-654-3210',
        'location': 'Green Acres',
        'items': ['Carrots'],
      },
    ],
    'Broccoli': [
      {
        'name': 'Farmer Bob',
        'rating': 4.7,
        'phone': '555-555-5555',
        'location': 'Organic Farms',
        'items': ['Broccoli'],
      },
    ],
    'Spinach': [
      {
        'name': 'Farmer Sue',
        'rating': 4.4,
        'phone': '222-333-4444',
        'location': 'Green Fields',
        'items': ['Spinach'],
      },
    ],
    'Apples': [
      {
        'name': 'Farmer Tom',
        'rating': 4.6,
        'phone': '999-888-7777',
        'location': 'Apple Orchard',
        'items': ['Apples'],
      },
    ],
    'Bananas': [
      {
        'name': 'Farmer Ben',
        'rating': 4.8,
        'phone': '333-222-1111',
        'location': 'Banana Grove',
        'items': ['Bananas'],
      },
    ],
    'Grapes': [
      {
        'name': 'Farmer Grace',
        'rating': 4.7,
        'phone': '444-555-6666',
        'location': 'Grape Vineyards',
        'items': ['Grapes'],
      },
    ],
    'Roses': [
      {
        'name': 'Farmer Lily',
        'rating': 4.5,
        'phone': '555-666-7777',
        'location': 'Rose Garden',
        'items': ['Roses'],
      },
    ],
    'Lilies': [
      {
        'name': 'Farmer Laura',
        'rating': 4.6,
        'phone': '666-777-8888',
        'location': 'Flower Field',
        'items': ['Lilies'],
      },
    ],
    'Tulips': [
      {
        'name': 'Farmer Tim',
        'rating': 4.7,
        'phone': '777-888-9999',
        'location': 'Tulip Farm',
        'items': ['Tulips'],
      },
    ],
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrdersPage(
              orders: orders,
              onRemoveOrder: _removeOrder,
            ),
          ),
        );
      }
    });
  }

  void _addOrder(String product, Map<String, dynamic> farmer) {
    setState(() {
      orders.add({
        'product': product,
        'farmer': farmer,
      });
    });
  }

  void _removeOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  void _showFarmerDetails(Map<String, dynamic> farmer, String product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerDetailsPage(
          farmer: farmer,
          product: product,
          onAddOrder: _addOrder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter items if a category is selected
    List<Map<String, dynamic>>? filteredItems;
    if (selectedCategory != null) {
      filteredItems = categories[selectedCategory]!
          .where((item) =>
              item['name'].toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.grey[100], // Set background color for the page
      appBar: AppBar(
        title: Text(
          selectedCategory == null
              ? 'Select Category'
              : (selectedProduct == null
                  ? selectedCategory!
                  : selectedProduct!),
        ),
        leading: selectedCategory != null
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    if (selectedProduct != null) {
                      selectedProduct = null; // Go back to product list
                    } else {
                      selectedCategory = null; // Go back to the category list
                    }
                  });
                },
              )
            : null,
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search Products',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white, // Search bar background
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value; // Update search query
                      });
                    },
                  ),
                ),
                Expanded(
                  child: selectedCategory == null
                      ? ListView.builder(
                          itemCount: categories.keys.length,
                          itemBuilder: (context, index) {
                            final category = categories.keys.elementAt(index);
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.purple[50]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 4), // Shadow position
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.purple[100]!,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                title: Text(category,
                                    style: TextStyle(fontSize: 18)),
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                              ),
                            );
                          },
                        )
                      : selectedProduct == null
                          ? ListView.builder(
                              itemCount: filteredItems?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = filteredItems![index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 204, 95, 223)!,
                                      width: 1,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(item['name'],
                                        style: TextStyle(fontSize: 18)),
                                    subtitle: Text('\$${item['price']}'),
                                    onTap: () {
                                      setState(() {
                                        selectedProduct = item['name'];
                                      });
                                    },
                                  ),
                                );
                              },
                            )
                          : ListView(
                              children: farmers[selectedProduct]!
                                  .map((farmer) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 6,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 209, 79, 232)!,
                                            width: 1,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Text(farmer['name'],
                                              style: TextStyle(fontSize: 18)),
                                          subtitle: Text(
                                              'Rating: ${farmer['rating']}'),
                                          onTap: () {
                                            _showFarmerDetails(
                                                farmer, selectedProduct!);
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                ),
              ],
            )
          : OrdersPage(
              orders: orders,
              onRemoveOrder: _removeOrder,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final Function(int) onRemoveOrder;

  OrdersPage({required this.orders, required this.onRemoveOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders yet'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.purple[100]!,
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    title:
                        Text(order['product'], style: TextStyle(fontSize: 18)),
                    subtitle: Text('Farmer: ${order['farmer']['name']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        onRemoveOrder(index);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class FarmerDetailsPage extends StatelessWidget {
  final Map<String, dynamic> farmer;
  final String product;
  final Function(String, Map<String, dynamic>) onAddOrder;

  FarmerDetailsPage({
    required this.farmer,
    required this.product,
    required this.onAddOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${farmer['name']} - $product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${farmer['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Rating: ${farmer['rating']}'),
            SizedBox(height: 8),
            Text('Phone: ${farmer['phone']}'),
            SizedBox(height: 8),
            Text('Location: ${farmer['location']}'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                onAddOrder(product, farmer);
                Navigator.pop(context);
              },
              child: Text('Add to Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
