import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo11_linechart/data/model/coin_response.dart';
import 'package:crypto_project_demo11_linechart/data/model/history.dart';
import 'package:crypto_project_demo11_linechart/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this.coinUsecase) : super(DetailInitial());
  CoinUsecase coinUsecase;
  final _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';
  double maxY = 0;
  double minY = 0;

  double roundUp(double n) {
    double x;
    double upN;
    if(n/10000 > 1) {
      x = 200;
      upN = n + (x - n%x);
      return upN;
    } else if(n/1000 > 1) {
      x = 20;
      upN = n + (x - n%x);
      return upN;
    } else if(n/100 > 1) {
      x = 2;
      upN = n + (x - n%x);
      return upN;
    } else if(n/10 > 1) {
      x = 0.2;
      upN = n + (x - n%x);
      return upN;
    }else if(n/10 < 0.01) {
      x = 0.1;
      upN = n + (x - n%x);
      return upN;
    } else if(n/10 < 0.1) {
      x = 0.2;
      upN = n + (x - n%x);
      return upN;
    }
    else if(n/10 < 1) {
      x = 0.02;
      upN = n + (x - n%x);
      return upN;
    }
    return upN = 0;
  }

  double roundDown(double n) {
    double x;
    double downN;
    if(n/10000 > 1) {
      x = 1000;
      downN = n - n%x;
      return downN;
    } else if(n/1000 > 1) {
      x = 100;
      downN = n - n%x;
      return downN;
    } else if(n/100 > 1) {
      x = 10;
      downN = n - n%x;
      return downN;
    } else if(n/10 > 1) {
      x = 1;
      downN = n - n%x;
      return downN;
    }else if(n/10 < 0.01) {
      x = 0.1;
      downN = n - n%x;
      return downN;
    } else if(n/10 < 0.1) {
      x = 0.2;
      downN = n - n%x;
      return downN;
    }
    else if(n/10 < 1) {
      x = 1;
      downN = n - n%x;
      return downN;
    }
    return downN = 0;
  }

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if(event is LoadDetailEvent) {
      yield LoadingDetailState();
      try {
        DateTime date = DateTime.now();
        String monthAgo = (DateTime(date.year ,date.month, date.day - 29)).toUtc().toIso8601String();
        final List<Coin>response = await coinUsecase.getCoin(_key, event.id);
        final List<History> historyResponse = await coinUsecase.getHistory(_key, event.id, monthAgo);
        historyResponse.elementAt(0).prices!.forEach((element) {
          if(double.parse(element) > maxY) {
            maxY = double.parse(element);
          }
        });
        minY = double.parse(historyResponse.elementAt(0).prices!.elementAt(0));
        historyResponse.elementAt(0).prices!.forEach((element) {
          if(double.parse(element) < minY) {
            minY = double.parse(element);
          }
        });

        maxY = roundUp(maxY);
        minY = roundDown(minY);
        yield LoadDetailSuccessState(response, historyResponse,maxY, minY);
      } catch (e) {
        yield LoadDetailFailureState();
      }
    }
  }
}
