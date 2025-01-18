import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penny_pilot/database/db_backup.dart'; // Your database helper

class Backup extends StatefulWidget {
  final String currentUserEmail;

  const Backup({super.key, required this.currentUserEmail});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  bool _databaseInitialized = false;
  List<Map<String, dynamic>> _backupHistory = [];

  @override
  void initState() {
    super.initState();
    _loadBackupHistory();
  }

  // Load backup history and reverse the order, then show only the latest 5 backups
  Future<void> _loadBackupHistory() async {
    try {
      final dbHelper = DatabaseBackup();
      final history = await dbHelper.getBackupByEmail(widget.currentUserEmail);

      setState(() {
        // Reverse the list to show latest first, and take only the first 5 backups
        _backupHistory = history.reversed.take(5).toList();
      });
    } catch (e) {
      print('Error loading backup history: $e');
    }
  }

  // Perform backup and save it to the app's writable directory
  Future<void> _performBackup(BuildContext context) async {
    try {
      final dbHelper = DatabaseBackup();
      final dbPath = await dbHelper.getDatabasePath();
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        throw 'Database file does not exist';
      }

      // Get the application documents directory
      final dir = await getApplicationDocumentsDirectory();
      final backupFileName = 'backup_${DateTime.now().toIso8601String()}.db';
      final backupPath = join(dir.path, backupFileName);

      // Ensure the backup directory is writable
      final backupDir = Directory(dir.path);
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true); // Create the directory if it doesn't exist
      }

      // Copy the database file to the backup location
      await dbFile.copy(backupPath);

      // Save the backup history locally
      final now = DateTime.now();
      final formattedDate = now.toLocal().toString().split(' ')[0];
      final formattedTime = now.toLocal().toString().split(' ')[1];

      await dbHelper.addBackup(formattedDate, formattedTime, widget.currentUserEmail);

      setState(() {
        _backupHistory.insert(0, {
          'date': formattedDate,
          'time': formattedTime,
        });

        // Limit to the most recent 5 backups
        _backupHistory = _backupHistory.take(5).toList();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Backup Successful to: $backupPath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Backup Failed: $e")),
      );
    }
  }

  Widget backupHistoryRow(Map<String, dynamic> entry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['date'] ?? 'Unknown Date',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              entry['time'] ?? 'Unknown Time',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
        const Icon(Icons.cloud_done, color: Colors.grey),
      ],
    );
  }

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
            // Last Backup Section
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color.fromARGB(255, 9, 104, 172),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Last Backup',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _backupHistory.isNotEmpty
                        ? '${_backupHistory.first['date']} at ${_backupHistory.first['time']}'
                        : 'No backups yet',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Backup Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _performBackup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        
                      ),
                    ),
                    child: const Text(
                      "Backup Now",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Backup History Section
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Backup History',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_backupHistory.isNotEmpty)
                          ..._backupHistory.map((entry) => Column(
                                children: [
                                  backupHistoryRow(entry),
                                  const SizedBox(height: 10),
                                ],
                              )),
                        if (_backupHistory.isEmpty)
                          const Text(
                            'No backup history available.',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
