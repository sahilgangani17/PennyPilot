import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penny_pilot/database/db_service.dart';
import 'package:penny_pilot/utils/icon_list.dart';
import 'package:penny_pilot/models/transaction.dart';
import 'package:penny_pilot/widgets/transaction_options_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionTile extends StatefulWidget {
  TransactionTile({
    super.key,
    required this.txn,
    required this.flutterLocalNotificationsPlugin,
  });

  var appicons = AppIcons();
  final Txn? txn;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  State<TransactionTile> createState() => _TransactionTile();
}

class _TransactionTile extends State<TransactionTile> {
  Txn? txn;
  Color? color;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    txn = widget.txn;
    color = txn?.type == 'Expenses' ? Colors.red : Colors.green;
    flutterLocalNotificationsPlugin = widget.flutterLocalNotificationsPlugin;
  }

  Future<void> _addNotification(String category, double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    String notification = '$category: \$${amount.toStringAsFixed(2)}';

    notifications.add(notification);
    await prefs.setStringList('notifications', notifications);

    // Check if notifications are enabled
    bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;

    if (!granted) {
      print("Notifications are not enabled for this app. Please enable them in system settings.");
      return;
    }

    // Show the notification if permissions are granted
    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        '$category Transaction',
        notification,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
          minVerticalPadding: 10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          leading: SizedBox(
            width: 70,
            height: 100,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color?.withOpacity(0.2),
              ),
              child: Center(
                child: FaIcon(
                    widget.appicons.getExpenseCategoryIcon(txn?.category ?? '')),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(txn?.category ?? '')),
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp, color: color, size: 17),
                  Text(
                    '${txn?.amount ?? 0.0}',
                    style: TextStyle(color: color, fontSize: 17),
                  )
                ],
              ),
              const SizedBox(width: 5),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn?.description ?? '!!!!',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    txn?.date ?? "DD / MM / YYYY",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: TransactionOptions(
                            txn: txn,
                            editTxnState: EditTxnStates.edit,
                            onTransactionComplete: (category, amount) {
                              _addNotification(category, amount);
                            },
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {
                      if (txn != null) {
                        DatabaseService.instance.deleteTxn(txn!);
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
