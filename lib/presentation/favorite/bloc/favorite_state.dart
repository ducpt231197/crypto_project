part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadingSuccessState extends FavoriteState {
  final List<Coin> listCoin;
  FavoriteLoadingSuccessState({required this.listCoin});
}

class FavoriteLoadingFailureState extends FavoriteState {}

class FavoriteIsEmptyState extends FavoriteState {}
