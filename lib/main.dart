import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/AllPages.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penny Pilot',
      builder: (context, child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)), child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        
      },
    );
  }
}
