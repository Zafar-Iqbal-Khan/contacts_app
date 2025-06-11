import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class LocalDbService {
  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) return;
    String path = join(await getDatabasesPath(), 'contacts.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE contacts(
            id TEXT PRIMARY KEY,
            name TEXT,
            phone TEXT,
            email TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertContact(Contact contact) async {
    await _db?.insert('contacts', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Contact>> getAllContacts() async {
    final List<Map<String, dynamic>> maps = await _db!.query('contacts');
    return List.generate(maps.length, (i) => Contact.fromMap(maps[i]));
  }

  static Future<void> updateContact(Contact contact) async {
    await _db?.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<void> deleteContact(String id) async {
    await _db?.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> clearAllContacts() async {
    await _db?.delete('contacts');
  }
}
