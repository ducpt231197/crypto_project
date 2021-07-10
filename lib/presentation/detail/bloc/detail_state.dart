part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class LoadDetailFailureState extends DetailState {}

class LoadingDetailState extends DetailState {}

class LoadDetailSuccessState extends DetailState {
  final List<Coin> coin;
  LoadDetailSuccessState(this.coin);
}