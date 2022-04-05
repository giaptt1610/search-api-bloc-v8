part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class Searching extends SearchState {}

class SearchSuccess extends SearchState {
  final List<GitHubUser> users;
  SearchSuccess(this.users);
}

class SearchFailed extends SearchState {}
