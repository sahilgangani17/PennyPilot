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
      "name": "Others",
      "icon": FontAwesomeIcons.cartPlus,
    }
  ];

  final List<Map<String, dynamic>> homeIncomeCategories = [
    {
      "name": "Salary",
      "icon": FontAwesomeIcons.sackDollar,
    },
    {
      "name": "Coupons",
      "icon": FontAwesomeIcons.receipt,
    },
    {
      "name": "Others",
      "icon": FontAwesomeIcons.cartPlus,
    }
  ];

  final List<Map<String, dynamic>> currency = [
    {
      "name": "Rupee",
      "icon": FontAwesomeIcons.indianRupeeSign,
    },
    // You can add more currencies here
    {
      "name": "Dollar",
      "icon": FontAwesomeIcons.dollarSign,
    },
    {
      "name": "Euro",
      "icon": FontAwesomeIcons.euroSign,
    },
  ];

  List<Map<String, dynamic>> getTxnType(String? type) {
    switch(type) {
      case 'Expenses': return homeExpenseCategories;
      case 'Income': return homeIncomeCategories;
    }
    return [];
  }

  IconData getExpenseCategoryIcon(String categoryName) {
    final category = homeExpenseCategories.firstWhere(
      (category) => category['name'] == categoryName,
      orElse: () => {'icon': FontAwesomeIcons.circleQuestion},
    );
    return category['icon'];
  }

  IconData getIncomeCategoryIcon(String categoryName) {
    final category = homeExpenseCategories.firstWhere(
      (category) => category['name'] == categoryName,
      orElse: () => {'icon': FontAwesomeIcons.circleQuestion},
    );
    return category['icon'];
  }

  // Method to get currency icon by name
  IconData getCurrencyIcon(String currencyName) {
    final currencyItem = currency.firstWhere(
      (currency) => currency['name'] == currencyName,
      orElse: () => {'icon': FontAwesomeIcons.circleQuestion},
    );
    return currencyItem['icon'];
  }
}
