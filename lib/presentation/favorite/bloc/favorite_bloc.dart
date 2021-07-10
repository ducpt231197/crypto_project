import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/data/utils/database.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/entities/coin_entity.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(this.coinUsecase) : super(FavoriteInitial());
  CoinUsecase coinUsecase;
  List<Coin> listFinal = [];
  final _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteLoadingSuccessEvent) {
      yield FavoriteLoadingState();
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      List<FavoriteCoin> listFavorite = await db.getCoin(event.email);
      if (listFavorite.isEmpty) {
        yield FavoriteIsEmptyState();
      } else {
        try{
          yield FavoriteLoadingState();
          final response = await coinUsecase.getTicker(_key);
          List<Coin>listCoin = response;
          for(int i = 0; i < listFavorite.length; i++) {
            for(int j = 0; j < listCoin.length; j++) {
              if(listFavorite.elementAt(i).coin == listCoin.elementAt(j).id) {
                listFinal.add(listCoin.elementAt(j));
                break;
              }
            }
          }
          yield FavoriteLoadingSuccessState(listCoin: listFinal);
        }catch(e) {
          yield FavoriteLoadingFailureState();
        }
      }
    }
  }
}
