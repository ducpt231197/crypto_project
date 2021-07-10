import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:meta/meta.dart';


part 'home_event.dart';

part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.coinUsecase) : super(HomeInitial());
  CoinUsecase coinUsecase;
  List<Coin> list = [];
  final _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';


  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadingSuccessEvent) {
      yield HomeLoadingState();
      try {
        final response = await coinUsecase.getTicker(_key);
        list = response;
        yield HomeLoadingSuccessState(listCoin: list);
      } catch (e) {
        yield HomeLoadingFailureState();
        throw Exception(e);
      }
    }

  }
}
