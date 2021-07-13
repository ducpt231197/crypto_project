import 'package:crypto_project_demo11_linechart/domain/coin_Usecase/entities/coin_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabase {
  Database? database;

  Future<void> openDB() async {
      database ??= await openDatabase(
        join(await getDatabasesPath(), 'favorite_database.db'),
        onCreate: (Database db, int version) {
          return db.execute(
            'CREATE TABLE watchlist(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, coin TEXT)',
          );
        },
        version: 1,
      );
  }

  Future<void> insertFavorite(FavoriteCoin coin) async {


    await database!.insert(
      'watchlist',
      coin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String email, String coin) async {
    await database!.delete(
      'watchlist',
      where: 'email = ? AND coin =?',
      whereArgs: [email, coin],
    );
  }

  Future<List<FavoriteCoin>> getCoin(String email) async {
    final List<Map<String, dynamic>> maps =
        await database!.query('watchlist', where: 'email = ?', whereArgs: [email]);

    return List.generate(
      maps.length,
      (i) {
        return FavoriteCoin(
          email: maps[i]['email'],
          coin: maps[i]['coin'],
        );
      },
    );
  }

  Future<bool> checkExist(String email, String coin) async {
    final List<Map<String, dynamic>> maps = await database!.query('watchlist',
        where: 'email = ? AND coin =?', whereArgs: [email, coin]);
    bool isExist;
    if (maps.isNotEmpty) {
      isExist = true;
      return isExist;
    } else {
      isExist = false;
      return isExist;
    }
  }

  Future<List<FavoriteCoin>> getCoinByEmailAndCoin(String email, String coin) async {
    final List<Map<String, dynamic>> maps = await database!.query('watchlist',
        where: 'email = ? AND coin =?', whereArgs: [email, coin]);
    return List.generate(
      maps.length,
          (i) {
        return FavoriteCoin(
          email: maps[i]['email'],
          coin: maps[i]['coin'],
        );
      },
    );
  }
}
