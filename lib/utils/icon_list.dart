import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpenseCategories = [
    {
      "name": "Clothing",
      "icon": FontAwesomeIcons.shirt,
    },
    {
      "name": "Food",
      "icon": FontAwesomeIcons.hamburger,
    },
    {
      "name": "Transport",
      "icon": FontAwesomeIcons.car,
    },
    {
      "name": "Grocery",
      "icon": FontAwesomeIcons.shoppingCart,
    },
    {
      "name": "Education",
      "icon": FontAwesomeIcons.graduationCap,
    },
    {
      "name": "Health",
      "icon": FontAwesomeIcons.medkit,
    },
    {
      "name": "Entertainment",
      "icon": FontAwesomeIcons.tv,
    },
    {
      "name": "Utilities and Bills",
      "icon": FontAwesomeIcons.lightbulb,
    },
    {
      "name": "Insurance",
      "icon": FontAwesomeIcons.shieldAlt,
    },
    // {
    //   "name": "Savings",
    //   "icon": FontAwesomeIcons.piggyBank,
    // },
    {
      "name": "Loans",
      "icon": FontAwesomeIcons.moneyBill,
    },
    {
      "name": "Vacation",
      "icon": FontAwesomeIcons.sun,
    },
    {
      "name": "Gifts",
      "icon": FontAwesomeIcons.gift,
    },
    {
      "name" : "Others",
      "icon" : FontAwesomeIcons.cartPlus,
    }
  ];

  IconData getExpensecategoryIcon(String categoryname) {
      final category = homeExpenseCategories.firstWhere(
        (category) =>   category['name'] == categoryname, 
        orElse: ()=> {
          "icon" : FontAwesomeIcons.poo
        }
      );
    return category['icon'];
  }
}
