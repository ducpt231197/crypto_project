
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';

abstract class CoinRepository {
  Future<List<Coin>> getTicker(String key);
  Future<List<Coin>> getCoin(String key, String coin);
}