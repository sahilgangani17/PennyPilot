import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/login.dart';
import 'package:penny_pilot/widgets/transaction_options_dialog.dart';
import 'dashboard_page.dart';
import 'analysis_page.dart';
import 'savings_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLogoutLoading = false;

  logout() async {
    setState(() {
      isLogoutLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  Login()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout failed')));
    } finally {
      setState(() {
        isLogoutLoading = false;
      });
    }
  }

  int _selectedIndex = 1; //TODO -- Change index 

  final List<dynamic> _pages = [
    Dashboard(),
    AnalysisPage(),
    null,
    SavingGoals(),
    SettingsPage(),
  ];


  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        return (await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to exit the app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          //backgroundColor: Colors.blueGrey[200],
          //toolbarHeight: 64,
          //centerTitle: true,
          title:Text(
            'PennyPilot',
            style: TextStyle(color: Colors.black, fontSize: 32, fontFamily: 'Lexend Deca')
          ),
          actions: [
            IconButton(
              onPressed: () {
                logout();
              },
              icon: isLogoutLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.logout),
            )
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 32,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Analysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc, color: Colors.transparent),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.savings),
              label: 'Savings',
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
      ),
    );
  }

  void _openNewTransaction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TransactionOptions(),
      ),
    );
  }
}
