part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class LoadDetailFailureState extends DetailState {}

class LoadingDetailState extends DetailState {}

class LoadDetailSuccessState extends DetailState {
  final List<Coin> coin;
  final List<History> history;
  final double? maxY;
  final double? minY;
  LoadDetailSuccessState(this.coin, this.history, this.maxY, this.minY);
}