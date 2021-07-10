part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class LoadDetailEvent extends DetailEvent {
  final String id;
  LoadDetailEvent(this.id);
}