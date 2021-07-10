class DetailCoin {
  DetailCoin({
    required this.id,
    required this.currency,
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.status,
    required this.price,
    required this.priceDate,
    required this.priceTimestamp,
    required this.circulatingSupply,
    required this.maxSupply,
    required this.marketCap,
    required this.marketCapDominance,
    required this.numExchanges,
    required this.numPairs,
    required this.numPairsUnmapped,
    required this.firstCandle,
    required this.firstTrade,
    required this.firstOrderBook,
    required this.rank,
    required this.rankDelta,
    required this.high,
    required this.highTimestamp,
    required this.the1D,
  });

  String? id;
  String? currency;
  String? symbol;
  String? name;
  String? logoUrl;
  String? status;
  String? price;
  DateTime? priceDate;
  DateTime? priceTimestamp;
  String? circulatingSupply;
  String? maxSupply;
  String? marketCap;
  String? marketCapDominance;
  String? numExchanges;
  String? numPairs;
  String? numPairsUnmapped;
  DateTime? firstCandle;
  DateTime? firstTrade;
  DateTime? firstOrderBook;
  String? rank;
  String? rankDelta;
  String? high;
  DateTime? highTimestamp;
  The1D? the1D;

  factory DetailCoin.fromJson(Map<String, dynamic>? json) => DetailCoin(
    id: json?["id"],
    currency: json?["currency"],
    symbol: json?["symbol"],
    name: json?["name"],
    logoUrl: json?["logo_url"],
    status: json?["status"],
    price: json?["price"],
    priceDate: DateTime.tryParse(json?["price_date"]),
    priceTimestamp: DateTime.tryParse(json?["price_timestamp"]),
    circulatingSupply: json?["circulating_supply"],
    maxSupply: json?["max_supply"],
    marketCap: json?["market_cap"],
    marketCapDominance: json?["market_cap_dominance"],
    numExchanges: json?["num_exchanges"],
    numPairs: json?["num_pairs"],
    numPairsUnmapped: json?["num_pairs_unmapped"],
    firstCandle: DateTime.tryParse(json?["first_candle"]),
    firstTrade: DateTime.tryParse(json?["first_trade"]),
    firstOrderBook: DateTime.tryParse(json?["first_order_book"]),
    rank: json?["rank"],
    rankDelta: json?["rank_delta"],
    high: json?["high"],
    highTimestamp: DateTime.tryParse(json?["high_timestamp"]),
    the1D: The1D.fromJson(json?["1d"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currency": currency,
    "symbol": symbol,
    "name": name,
    "logo_url": logoUrl,
    "status": status,
    "price": price,
    "price_date": priceDate?.toIso8601String(),
    "price_timestamp": priceTimestamp?.toIso8601String(),
    "circulating_supply": circulatingSupply,
    "max_supply": maxSupply,
    "market_cap": marketCap,
    "market_cap_dominance": marketCapDominance,
    "num_exchanges": numExchanges,
    "num_pairs": numPairs,
    "num_pairs_unmapped": numPairsUnmapped,
    "first_candle": firstCandle?.toIso8601String(),
    "first_trade": firstTrade?.toIso8601String(),
    "first_order_book": firstOrderBook?.toIso8601String(),
    "rank": rank,
    "rank_delta": rankDelta,
    "high": high,
    "high_timestamp": highTimestamp?.toIso8601String(),
    "1d": the1D?.toJson(),
  };
}

class The1D {
  The1D({
    required this.volume,
    required this.priceChange,
    required this.priceChangePct,
    required this.volumeChange,
    required this.volumeChangePct,
    required this.marketCapChange,
    required this.marketCapChangePct,
  });

  String? volume;
  String? priceChange;
  String? priceChangePct;
  String? volumeChange;
  String? volumeChangePct;
  String? marketCapChange;
  String? marketCapChangePct;

  factory The1D.fromJson(Map<String, dynamic>? json) => The1D(
    volume: json?["volume"],
    priceChange: json?["price_change"],
    priceChangePct: json?["price_change_pct"],
    volumeChange: json?["volume_change"],
    volumeChangePct: json?["volume_change_pct"],
    marketCapChange: json?["market_cap_change"],
    marketCapChangePct: json?["market_cap_change_pct"],
  );

  Map<String, dynamic>? toJson() => {
    "volume": volume,
    "price_change": priceChange,
    "price_change_pct": priceChangePct,
    "volume_change": volumeChange,
    "volume_change_pct": volumeChangePct,
    "market_cap_change": marketCapChange,
    "market_cap_change_pct": marketCapChangePct,
  };
}
