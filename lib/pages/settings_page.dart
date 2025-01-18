import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:penny_pilot/pages/login.dart';
import 'package:penny_pilot/pages/settingsPages/accountdetails.dart';
import 'package:penny_pilot/pages/settingsPages/backup.dart';
import 'package:penny_pilot/pages/settingsPages/currencyconvertor.dart';
import 'package:penny_pilot/pages/settingsPages/help&support.dart';
import 'package:penny_pilot/pages/settingsPages/aboutus.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double currentRating = 3.0; // To store the current rating
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // bool notificationsEnabled = false; // To manage notification state

  //@override
  void initState() {
    super.initState();
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //const AndroidInitializationSettings initializationSettingsAndroid =
      //  AndroidInitializationSettings('app_icon');

    //const InitializationSettings initializationSettings = InitializationSettings(
      //android: initializationSettingsAndroid,
    //);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // _loadNotificationState(); // Load notification state
  }

  // Load notification state from SharedPreferences
  // Future<void> _loadNotificationState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
  //   });
  // }

  // Show a test notification when the switch is turned on
  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     channelDescription: 'your_channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );

  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Test Notification',
  //     'This is a test notification body.',
  //     platformChannelSpecifics,
  //   );
  // }

  // Save notification state to SharedPreferences
  // Future<void> _saveNotificationState(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('notifications_enabled', value);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(100, 200, 213, 185),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Settings Section
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SectionTitle(title: "Account Settings"),
                    SettingsCard(
                      icon: Icons.switch_account_rounded,
                      title: "Switch Accounts",
                      subtitle: "Login to another account",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                    SettingsCard(
                      icon: Icons.account_circle,
                      title: "Account Details",
                      subtitle: "Manage your personal information",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Accountdetails(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // App Settings Section
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SectionTitle(title: "App Settings"),
                    SettingsCard(
                      icon: Icons.currency_exchange,
                      title: "Currency Converter",
                      subtitle: "Change your preferred currency",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Currencyconvertor(),
                          ),
                        );
                      },
                    ),
                    SettingsCard(
                      icon: Icons.backup,
                      title: "Backup",
                      subtitle: "Manage your data backup",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Backup(),
                          ),
                        );
                      },
                    ),
                    //Notification
                  //   SettingsToggleCard(
                  //     icon: Icons.notifications,
                  //     title: "Notifications",
                  //     subtitle: "Manage your notifications",
                  //     value: notificationsEnabled,
                  //     onChanged: (value) async {
                  //       setState(() {
                  //         notificationsEnabled = value;
                  //       });

                  //       // Save the notification state to SharedPreferences
                  //       await _saveNotificationState(notificationsEnabled);

                  //       // Show a notification if the switch is turned on
                  //       if (notificationsEnabled) {
                  //         _showNotification();
                  //       }
                  //     },
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const Notifications(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Support Section
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SectionTitle(title: "Support"),
                    SettingsCard(
                      icon: Icons.help_rounded,
                      title: "Help & Support",
                      subtitle: "Get assistance and FAQs",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Helpsupport(),
                          ),
                        );
                      },
                    ),
                    SettingsCard(
                      icon: Icons.info,
                      title: "About Us",
                      subtitle: "Get To Know Us",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUs(),
                          ),
                        );
                      },
                    ),
                    // Rate Us
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, right: 16, left: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              title: const Text("Rate Us"),
                              subtitle: Text(
                                "Your Rating: ${currentRating.toStringAsFixed(1)}",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RatingBar.builder(
                              initialRating: currentRating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 32.0,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  currentRating = rating;
                                });
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Thank you for rating us ${currentRating.toStringAsFixed(1)} stars!"),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueGrey[300],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ),
                                child: const Text("Submit"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class SettingsToggleCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTap;

  const SettingsToggleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  State<SettingsToggleCard> createState() => _SettingsToggleCardState();
}

class _SettingsToggleCardState extends State<SettingsToggleCard> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: ListTile(
          leading: Icon(widget.icon, color: Colors.blueGrey),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          trailing: Switch(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });
              widget.onChanged(newValue);
            },
            activeColor: Colors.blueGrey[300],
          ),
        ),
      ),
    );
  }
}
