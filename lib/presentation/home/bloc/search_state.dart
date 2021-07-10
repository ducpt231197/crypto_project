part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchingState extends SearchState{}

class SearchSuccessState extends SearchState {
  final List<Coin> resultList;
  SearchSuccessState({required this.resultList});
}

class SearchFailureState extends SearchState{}

class SearchNull extends SearchState{}
