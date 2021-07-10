

import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/repositories/coin_repository.dart';

class CoinUsecase {
  final CoinRepository coinRepository;

  CoinUsecase(this.coinRepository);
  Future<List<Coin>> getTicker(String key) => coinRepository.getTicker(key);
  Future<List<Coin>> getCoin(String key, String coin) => coinRepository.getCoin(key,coin);
}