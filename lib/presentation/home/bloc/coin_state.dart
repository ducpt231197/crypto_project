part of 'coin_bloc.dart';

@immutable
abstract class CoinState {}

class CoinInitial extends CoinState {}

class SortNameState extends CoinState {
  final List<Coin> sortList;

  SortNameState({required this.sortList});
}

class SortPriceState extends CoinState {
  final List<Coin> sortList;

  SortPriceState({required this.sortList});
}

class AddingFavoriteState extends CoinState {}

class AddFavoriteSuccessState extends CoinState {
  final String coin;
  AddFavoriteSuccessState(this.coin);
}

class AddFavoriteFailureState extends CoinState {}

class DeleteFavoriteSuccessState extends CoinState {}
