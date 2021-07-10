import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchingEvent) {
      yield SearchingState();
      final List<Coin> resultList = event.listCurrency.where((element) => element.name!.toLowerCase().contains(event.txtSearch.toLowerCase())).toList();

      if(event.txtSearch.isEmpty) {
        yield SearchNull();
      } else if(resultList.isNotEmpty) {
        yield SearchSuccessState(resultList: resultList);
      } else{
        yield SearchFailureState();
      }

    }
  }
}
