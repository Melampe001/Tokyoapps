import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/spin_result.dart';
import '../models/user_subscription.dart';

/// Local storage service for offline mode
class StorageService {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'roulette.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE spins (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            number INTEGER NOT NULL,
            timestamp TEXT NOT NULL,
            method TEXT NOT NULL,
            isEuropean INTEGER NOT NULL
          )
        ''');
      },
    );
  }
  
  /// Save spin result to local database
  Future<void> saveSpinResult(SpinResult spin) async {
    final db = await database;
    await db.insert(
      'spins',
      {
        'number': spin.number,
        'timestamp': spin.timestamp.toIso8601String(),
        'method': spin.method,
        'isEuropean': spin.isEuropean ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  /// Get all spin results
  Future<List<SpinResult>> getAllSpins() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'spins',
      orderBy: 'timestamp DESC',
    );
    
    return List.generate(maps.length, (i) {
      return SpinResult(
        id: maps[i]['id'] as int?,
        number: maps[i]['number'] as int,
        timestamp: DateTime.parse(maps[i]['timestamp'] as String),
        method: maps[i]['method'] as String,
        isEuropean: maps[i]['isEuropean'] == 1,
      );
    });
  }
  
  /// Get recent spins (for quick access)
  Future<List<SpinResult>> getRecentSpins({int limit = 100}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'spins',
      orderBy: 'timestamp DESC',
      limit: limit,
    );
    
    return List.generate(maps.length, (i) {
      return SpinResult(
        id: maps[i]['id'] as int?,
        number: maps[i]['number'] as int,
        timestamp: DateTime.parse(maps[i]['timestamp'] as String),
        method: maps[i]['method'] as String,
        isEuropean: maps[i]['isEuropean'] == 1,
      );
    });
  }
  
  /// Clear all spin history
  Future<void> clearSpinHistory() async {
    final db = await database;
    await db.delete('spins');
  }
  
  /// Update a specific spin result
  Future<void> updateSpinResult(SpinResult spin) async {
    if (spin.id == null) {
      throw ArgumentError('Cannot update spin result without an id');
    }
    final db = await database;
    await db.update(
      'spins',
      {
        'number': spin.number,
        'timestamp': spin.timestamp.toIso8601String(),
        'method': spin.method,
        'isEuropean': spin.isEuropean ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [spin.id],
    );
  }
  
  /// Delete a specific spin result
  Future<void> deleteSpinResult(int id) async {
    final db = await database;
    await db.delete(
      'spins',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  /// Get spin count by method
  Future<Map<String, int>> getSpinCountByMethod() async {
    final db = await database;
    final manualCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM spins WHERE method = ?', ['manual'])
    ) ?? 0;
    
    final cameraCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM spins WHERE method = ?', ['camera'])
    ) ?? 0;
    
    return {
      'manual': manualCount,
      'camera': cameraCount,
    };
  }
  
  /// Save user subscription to SharedPreferences
  Future<void> saveSubscription(UserSubscription subscription) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('subscription', jsonEncode(subscription.toJson()));
  }
  
  /// Get user subscription from SharedPreferences
  Future<UserSubscription?> getSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    final subscriptionJson = prefs.getString('subscription');
    
    if (subscriptionJson == null) return null;
    
    return UserSubscription.fromJson(jsonDecode(subscriptionJson));
  }
  
  /// Save app preferences
  Future<void> savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }
  
  /// Get app preference
  Future<dynamic> getPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
