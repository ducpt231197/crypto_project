import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'coin_api.g.dart';

@RestApi(baseUrl: "https://api.nomics.com/v1")
abstract class CoinAPI {
  factory CoinAPI(Dio dio) = _CoinAPI;

  @GET("/currencies/ticker")
  Future<List<Coin>> getTicker(
    @Query("key") String key,
    @Query("interval") String interval,
    @Query("per-page") String perPage,
    @Query("page") String page,
  );
  @GET("/currencies/ticker")
  Future<List<Coin>> getCoin(
    @Query("key") String key,
    @Query("interval") String interval,
    @Query("ids") String ids,
  );
}
