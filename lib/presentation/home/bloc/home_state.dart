part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<Coin> listCoin;
  HomeLoadingSuccessState({required this.listCoin});
}

class HomeLoadingFailureState extends HomeState {}


