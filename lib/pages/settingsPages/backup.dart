import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import

class Backup extends StatefulWidget {
  const Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  bool _databaseInitialized = false;
  bool isBackupEnabled = false;
  double _storageUsagePercentage = 0.0;
  int _usedStorage = 0;
  int _totalStorage = 1000; // Set total storage to 1000 MB for now
  List<Map<String, String>> _backupHistory = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Database?> _getDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'penny_pilot.db');
      return openDatabase(path, onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      }, version: 1);
    } catch (e) {
      print('Error initializing database: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _loadBackupHistory();
    _calculateStorageUsage();
  }

  Future<void> _initDatabase() async {
    final db = await _getDatabase();
    if (db != null) {
      setState(() {
        _databaseInitialized = true;
      });
      _calculateStorageUsage();
    }
  }

  Future<void> _loadBackupHistory() async {
    try {
      final snapshot = await _firestore.collection('backupHistory').get();
      List<Map<String, String>> backupHistory = [];
      
      // Map the documents and safely handle missing or unexpected fields
      for (var doc in snapshot.docs) {
        final date = doc['date'] ?? 'Unknown Date';  // Default value if not found
        final time = doc['time'] ?? 'Unknown Time';  // Default value if not found

        backupHistory.add({
          'date': date.toString(),  // Ensure it's a string
          'time': time.toString(),  // Ensure it's a string
        });
      }

      setState(() {
        _backupHistory = backupHistory;
      });
    } catch (e) {
      print('Error loading backup history from Firestore: $e');
    }
  }

  Future<void> _saveBackupHistory(String date, String time) async {
    try {
      await _firestore.collection('backupHistory').add({
        'date': date,
        'time': time,
      });
    } catch (e) {
      print('Error saving backup history to Firestore: $e');
    }
  }

  Future<void> _performBackup(BuildContext context) async {
    try {
      final databasesPath = await getDatabasesPath();
      final dbPath = join(databasesPath, 'penny_pilot.db');
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        throw 'Database file does not exist';
      }

      final dir = await getApplicationDocumentsDirectory();
      final backupFileName = 'backup_${DateTime.now().toIso8601String()}.db';
      final backupPath = join(dir.path, backupFileName);

      await dbFile.copy(backupPath);

      final now = DateTime.now();
      final formattedDate = now.toLocal().toString().split(' ')[0];
      final formattedTime = now.toLocal().toString().split(' ')[1];

      await _saveBackupHistory(formattedDate, formattedTime);

      setState(() {
        _backupHistory.add({
          'date': formattedDate,
          'time': formattedTime,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Backup Successful to: $backupPath")),
      );

      _calculateStorageUsage();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Backup Failed: $e")),
      );
    }
  }

  Future<void> _calculateStorageUsage() async {
    if (!_databaseInitialized) return;

    try {
      final databasesPath = await getDatabasesPath();
      final dbPath = join(databasesPath, 'penny_pilot.db');
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        int fileSizeInBytes = await dbFile.length();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        setState(() {
          _usedStorage = fileSizeInMB.toInt();
          _storageUsagePercentage = _usedStorage / _totalStorage;
        });
      }
    } catch (e) {
      print('Error calculating storage usage: $e');
    }
  }

  Widget backupHistoryRow(Map<String, String> entry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['date'] ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              entry['time'] ?? '',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
        const Icon(Icons.cloud_done, color: Colors.indigoAccent),
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
            // Backup Details
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
                        ? '${_backupHistory.last['date']} at ${_backupHistory.last['time']}'
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

            // Backup Options
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
                    'Backup Options',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Backup
                  Container(
                    padding: const EdgeInsets.all(20),
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
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Backup',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isBackupEnabled,
                              onChanged: (value) {
                                setState(() {
                                  isBackupEnabled = value;
                                });
                                if (value) {
                                  _performBackup(context);
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Save your data to the device storage',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Backup History
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
            const SizedBox(height: 20),

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
                        '$_usedStorage MB',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _storageUsagePercentage,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      '${(_storageUsagePercentage * 100).toInt()}% of $_totalStorage MB used'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
