import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penny_pilot/utils/icon_list.dart';

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  TransactionCard({
    super.key,
  });

  var appicons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10), 
          ListView.builder(
            shrinkWrap: true, 
            physics: NeverScrollableScrollPhysics(), 
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        color: Colors.grey.withOpacity(0.09),
                        blurRadius: 10,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    minVerticalPadding: 10 ,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    leading: Container(
                      width: 70,
                      height: 100,
                      child: Container(
                        width: 30, 
                        height: 30 ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.green.withOpacity(0.2)
                        ), 
                        child: Center(
                          child: FaIcon(appicons.getExpensecategoryIcon('transport'))
                          ), 
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(child: Text("Car Loan")),
                        Spacer(),
                        Text(
                          "₹ 0000",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            Spacer(),
                            Text(
                              "₹ 000",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                        Text(
                          "25 / 12 / 2025",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

