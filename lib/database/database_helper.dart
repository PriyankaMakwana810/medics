import 'package:medics/models/article.dart';
import 'package:medics/models/medicine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static int version = 1;
  static String dbName = 'cartItems.db';

  static const String _tableCart = 'Cart';
  static const String _tableArticles = 'Article';

  static Future<Database> _getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $_tableCart (id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL,quantity TEXT NOT NULL,image TEXT NOT NULL,rate TEXT NOT NULL, price TEXT NOT NULL,discountedPrice TEXT NOT NULL,items INTEGER NOT NULL,description TEXT NOT NULL);');
      await db.execute(
          'CREATE TABLE $_tableArticles (id INTEGER PRIMARY KEY NOT NULL, title TEXT NOT NULL,tag TEXT NOT NULL,time TEXT NOT NULL,timeToRead TEXT NOT NULL, imageUrl TEXT NOT NULL,isSaved BOOLEAN);');
    }, version: version);
  }

  Future<int> saveToCart(Medicine medicine) async {
    final db = await _getDatabase();
    return db.insert(_tableCart, medicine.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> saveArticle(Article article) async {
    final db = await _getDatabase();
    return db.insert(_tableArticles, article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Medicine>> getCartValues() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableCart);

    return List.generate(
        maps.length, (index) => Medicine.fromJson(maps[index]));
  }

  static Future<List<Article>> getSavedArticles() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableArticles);
    return List.generate(maps.length, (index) => Article.fromJson(maps[index]));
  }

  Future<void> updateQuantity(int quantity, int id) async {
    Database db = await _getDatabase();
    db.rawUpdate(
        "UPDATE $_tableCart SET  items = '$quantity' WHERE id = '$id'");
  }

  Future<void> updateSavedArticles(bool isSaved, int id) async {
    Database db = await _getDatabase();
    db.rawUpdate(
        "UPDATE $_tableArticles SET  isSaved = '$isSaved' WHERE id = '$id'");
  }

  Future<int> deleteFromCart(int id) async {
    Database db = await _getDatabase();
    return db.rawDelete("DELETE FROM $_tableCart  WHERE id = '$id'");
  }

  Future<int> deleteArticle(int id) async {
    Database db = await _getDatabase();
    return db.rawDelete("DELETE FROM $_tableArticles  WHERE id = '$id'");
  }
}
