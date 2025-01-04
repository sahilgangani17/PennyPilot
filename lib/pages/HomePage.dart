import 'package:flutter/material.dart';
import 'dashboard.dart'; // Dashboard page
// import 'profilepage.dart'; // Profile page
// import 'analysispage.dart'; // Analysis page
// import 'settings_page.dart'; // Settings page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),       // Home now points to Dashboard
    // const AnalysisPage(),    // Analysis page
    // const ProfilePage(),     // Profile page
    // const SettingsPage(),    // Settings page
  ];

  void _onItemTapped(int index) {
    if (index != 2) { // Ignore the middle "invisible" item
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 32,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',  // This now links to the Dashboard
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc, color: Colors.transparent),
            label: '', // Invisible middle item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewTransaction,
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openNewTransaction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                icon: Icon(Icons.currency_rupee_sharp),
                hintText: '0',
                labelText: 'Amount',
              ),
            ),
            TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(
                icon: Icon(Icons.more_horiz),
                hintText: 'Others',
                labelText: 'Category',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
