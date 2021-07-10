import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.coinUsecase) : super(DetailInitial());
  CoinUsecase coinUsecase;
  final _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if(event is LoadDetailEvent) {
      yield LoadingDetailState();
      try {
        final List<Coin>response = await coinUsecase.getCoin(_key, event.id);
        yield LoadDetailSuccessState(response);
      } catch (e) {
        yield LoadDetailFailureState();
      }
    }
  }
}
