import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpenseCategories = [
    {
      "name": "clothing",
      "icon": FontAwesomeIcons.shirt,
    },
    {
      "name": "food",
      "icon": FontAwesomeIcons.hamburger,
    },
    {
      "name": "transport",
      "icon": FontAwesomeIcons.car,
    },
    {
      "name": "grocery",
      "icon": FontAwesomeIcons.shoppingCart,
    },
    {
      "name": "education",
      "icon": FontAwesomeIcons.graduationCap,
    },
    {
      "name": "health",
      "icon": FontAwesomeIcons.medkit,
    },
    {
      "name": "entertainment",
      "icon": FontAwesomeIcons.tv,
    },
    {
      "name": "utilities",
      "icon": FontAwesomeIcons.lightbulb,
    },
    {
      "name": "insurance",
      "icon": FontAwesomeIcons.shieldAlt,
    },
    {
      "name": "savings",
      "icon": FontAwesomeIcons.piggyBank,
    },
    {
      "name": "loans",
      "icon": FontAwesomeIcons.moneyBill,
    },
    {
      "name": "vacation",
      "icon": FontAwesomeIcons.sun,
    },
    {
      "name": "gifts",
      "icon": FontAwesomeIcons.gift,
    },
    {
      "name" : "others",
      "icon" : FontAwesomeIcons.cartPlus,
    }
  ];

  IconData getExpensecategoryIcon(String categoryname){
      final category = homeExpenseCategories.firstWhere(
        (category) =>   category['name'] == categoryname, 
        orElse: ()=> {"icon" : FontAwesomeIcons.shirt} );
    return category['icon'];
  }

}
