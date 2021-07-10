part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteLoadingSuccessEvent extends FavoriteEvent {
  final String email;
  FavoriteLoadingSuccessEvent(this.email);
}
