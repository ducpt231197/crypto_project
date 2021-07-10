part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchingEvent extends SearchEvent{
  final String txtSearch;
  final List<Coin> listCurrency;

  SearchingEvent(this.txtSearch, this.listCurrency);
}
