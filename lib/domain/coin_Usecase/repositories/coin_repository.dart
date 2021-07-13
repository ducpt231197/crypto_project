
import 'package:crypto_project_demo11_linechart/data/model/coin_response.dart';
import 'package:crypto_project_demo11_linechart/data/model/history.dart';

abstract class CoinRepository {
  Future<List<Coin>> getTicker(String key);
  Future<List<Coin>> getCoin(String key, String coin);
  Future<List<History>> getHistory(String key, String coin, String date);
}