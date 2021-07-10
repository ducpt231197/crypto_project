// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CoinAPI implements CoinAPI {
  _CoinAPI(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.nomics.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Coin>> getTicker(key, interval, perPage, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': key,
      r'interval': interval,
      r'per-page': perPage,
      r'page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Coin>>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/currencies/ticker',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Coin.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Coin>> getCoin(key, interval, ids) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': key,
      r'interval': interval,
      r'ids': ids
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Coin>>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/currencies/ticker',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Coin.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
