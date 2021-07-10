part of 'coin_bloc.dart';

@immutable
abstract class CoinEvent {}

class SortPriceEvent extends CoinEvent{
  final bool isAscending;
  final List<Coin> listCurrency;

  SortPriceEvent(this.listCurrency, this.isAscending);
}

class SortNameEvent extends CoinEvent{
  final bool isAscending;
  final List<Coin> listCurrency;

  SortNameEvent(this.listCurrency, this.isAscending);
}

class AddFavoriteEvent extends CoinEvent{
  final String email;
  final String coin;
  AddFavoriteEvent({required this.coin, required this.email});
}

class DeleteFavoriteEvent extends CoinEvent {
  final String email;
  final String coin;
  DeleteFavoriteEvent({required this.coin, required this.email});
}
