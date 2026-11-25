

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/producto.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
    
  }


  Future<Database> _initDatabase() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'inventario.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

  }


  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE productos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT,
        precio REAL NOT NULL CHECK (precio >= 0),
        cantidad INTEGER NOT NULL CHECK (cantidad >= 0)
      )
    ''');

  }


  Future<int> insertarProducto(Producto producto) async {

    final db = await database;

    final datos = producto.toMap();
    datos.remove('id');

    return await db.insert('productos', datos);

  }


  Future<List<Producto>> obtenerProductos() async {

    final db = await database;

    final List<Map<String, dynamic>> registros = await db.query(
      'productos',
      orderBy: 'nombre ASC',
    );

    return registros.map((map) => Producto.fromMap(map)).toList();
    
  }


  Future<int> actualizarProducto(Producto producto) async {

    final db = await database;

    final datos = producto.toMap();
    datos.remove('id');

    return await db.update(
      'productos',
      datos,
      where: 'id = ?',
      whereArgs: [producto.id],
    );

  }


  Future<int> eliminarProducto(int id) async {

    final db = await database;

    return await db.delete(
      'productos',
      where: 'id = ?',
      whereArgs: [id],
    );

  }

}