import 'package:crypto_project_demo10_database/data/api/coin_api.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/repositories/coin_repository.dart';

class CoinRespositoryImpl extends CoinRepository{
  CoinAPI coinApi;
  CoinRespositoryImpl(this.coinApi);
  @override
  Future<List<Coin>> getTicker(String key)async {
    try {
      final response = await coinApi.getTicker(key, '1h,1d,7d', '100', '1',);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Coin>> getCoin(String key, String coin)async {
    try {
      final response = await coinApi.getCoin(key, '1d', coin);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

}