import 'package:flutter/material.dart';

class Backup extends StatefulWidget {
  const Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  bool isCloudBackupEnabled = false; // State for cloud backup toggle
  bool isLocalBackupEnabled = false; // State for local backup toggle

  //storage variables
  final double _storageUsagePercentage = 0.0;
  final int _usedStorage = 0;
  final int _totalStorage = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Backup"),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Backup Details like last backup
            Container(
              padding: const EdgeInsets.all(20),
              color: Color.fromARGB(255, 9, 104, 172),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Last Backup',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '(Date) - (Time)',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'All your financial data is securely stored',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Backup Optionns
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Backup Options',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Cloud Backup
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Cloud Backup',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isCloudBackupEnabled,
                              onChanged: (value) {
                                setState(() {
                                  isCloudBackupEnabled = value;
                                  // TODO: Implement cloud backup logic
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Automatically backup data to secure cloud storage',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Local Backup
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Local Backup',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isLocalBackupEnabled,
                              onChanged: (value) {
                                setState(() {
                                  isLocalBackupEnabled = value;
                                  // TODO: Implement local backup logic
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Save backup files to your device storage',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Backup History
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Backup History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Details..
                        // Eg --> 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '(Date)',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(Time)',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.cloud_done,
                              color: Colors.indigoAccent,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Eg --> 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '(Date)',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(Time)',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.cloud_done,
                              color: Colors.indigoAccent,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Eg --> 3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '(Date)',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(Time)',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.cloud_done,
                              color: Colors.indigoAccent,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Storage Usage
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Storage Usage',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Used Space',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        // Dynamically update this text
                        '$_usedStorage MB', // Example. Replace with actual usage.
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    // Progress Bar
                    value: _storageUsagePercentage, // Example: 0.45 for 45%
                    backgroundColor:
                        Colors.grey[300], // Customize background color
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue), // Progress color
                  ),
                  const SizedBox(height: 10),
                  Text(
                      '${(_storageUsagePercentage * 100).toInt()}% of $_totalStorage MB used'), // Dynamic
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromWidth(300)),
                backgroundColor: WidgetStatePropertyAll(Colors.grey),
              ),
              onPressed: () {},
              icon: Icon(
                Icons.backup_sharp,
                color: Colors.white,
              ),
              label: Text(
                'Backup Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
