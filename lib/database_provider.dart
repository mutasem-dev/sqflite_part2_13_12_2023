import 'package:product_sqlite2/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static int version = 1;
  final String tableName = 'products';
  static Database? _database;

  Future<Database> get database async{
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'products.db';
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute(
            '''
            create table $tableName (
              id integer primary key autoincrement,
              name text not null unique,
              quantity integer not null,
              price double no null
            )
            '''
        );
      },
    );
  }
  Future<int> insertProduct(Product p) async {
    final db = await database;
    return await db.insert(tableName, p.toMap());
  }
  Future<int> removeProduct(Product p) async {
    final db = await database;
    return await db.delete(tableName,where: 'id=?',whereArgs: [p.id]);
  }
  Future<int> updateProduct(Product p) async {
    final db = await database;
    return await db.update(tableName, p.toMap(),where: 'id=?',whereArgs: [p.id]);
  }
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(tableName);
    List<Product> products = [];
    for (var element in results) {
      Product p = Product.fromMap(element);
      products.add(p);
    }
    return products;
  }
  Future<Product> getProduct(int id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(tableName,where: 'id=?',whereArgs: [id]);
    return Product.fromMap(results[0]);
  }
  Future<int> removeAll() async {
    final db = await database;
    return await db.delete(tableName);
  }
}