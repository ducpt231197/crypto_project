import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/data/utils/database.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/entities/coin_entity.dart';
import 'package:meta/meta.dart';

part 'coin_event.dart';

part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc() : super(CoinInitial());

  @override
  Stream<CoinState> mapEventToState(CoinEvent event) async* {
    if (event is SortPriceEvent) {
      List<Coin> sortList = event.listCurrency;
      if (event.isAscending == true) {
        // sort the coin list in Descending, order by price
        sortList.sort((coinA, coinB) =>
            double.parse(coinB.price!).compareTo(double.parse(coinA.price!)));
      } else {
        // sort the coin list in Ascending, order by price
        sortList.sort((coinA, coinB) =>
            double.parse(coinA.price!).compareTo(double.parse(coinB.price!)));
      }
      yield SortPriceState(sortList: sortList);
    } else if (event is SortNameEvent) {
      List<Coin> sortList = event.listCurrency;
      if (event.isAscending == true) {
        // sort the coin list in Descending, order by name
        sortList.sort((coinA, coinB) => coinB.name!.compareTo(coinA.name!));
      } else {
        // sort the coin list in Ascending, order by name
        sortList.sort((coinA, coinB) => coinA.name!.compareTo(coinB.name!));
      }
      yield SortNameState(sortList: sortList);
    } else if (event is AddFavoriteEvent) {
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      var coin = FavoriteCoin(
        coin: event.coin,
        email: event.email,
      );

      bool isExist = await db.checkExist(event.email, event.coin);
      if(isExist) {
        yield AddFavoriteFailureState();
      } else {
        yield AddingFavoriteState();
        await db.insertFavorite(coin);
        yield AddFavoriteSuccessState(event.coin);
      }
    } else if(event is DeleteFavoriteEvent) {
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      await db.deleteFavorite(event.email, event.coin);
      yield DeleteFavoriteSuccessState();
    }
  }
}
